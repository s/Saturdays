//
//  IssueListView.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Shimmer

protocol IssueListViewProtocol {
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(message:String)
    func show(issues:***REMOVED***IssueViewModel***REMOVED***)
}

fileprivate enum OSVersion : Int {
    case eleven
    case ten
}

class IssueListView : UIViewController {
    
    //MARK: Properties
    fileprivate let osVersion : OSVersion
    fileprivate let presenter : IssueListPresenter
    fileprivate let imageDownloadService : ImageDownloadService
    fileprivate lazy var tableViewDataSource : IssueListViewDataSource = { ***REMOVED***unowned self***REMOVED*** in
        
        let selectHandler : (IssueListViewDataSourceSelection) -> Void = { ***REMOVED***unowned self***REMOVED*** (conf) in
            self.handleSelection(with:conf)
        }
        
        return IssueListViewDataSource(with: self.tableView,
                                       imageDownloadService:self.imageDownloadService,
                                       selectHandler: selectHandler)
    }()
    fileprivate lazy var issueDetailsAnimator : IssueDetailsAnimator = {
        return IssueDetailsAnimator()
    }()
    fileprivate var selectedIndexPath : IndexPath?
    
    
    //MARK: Subviews
    fileprivate let loadingIndicator : UIStackView = {
        let blocks = UIHelper.createShimmerBlocks(numberOf: 3)
        blocks.translatesAutoresizingMaskIntoConstraints = false
        return blocks
    }()
    
    fileprivate lazy var tableView : UITableView = { ***REMOVED***unowned self***REMOVED*** in
        let tableView = UITableView(frame:CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIDefines.Sizes.defaultIssueCellHeight
        return tableView
    }()
    
    fileprivate lazy var navigationBarView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIDefines.Colors.navigationBarTintColor
        view.addSubview(self.navigationBarContentView)
        view.addSubview(self.navigationBarLargeTitleView)
        view.bringSubview(toFront: self.navigationBarContentView)
        view.addConstraints(***REMOVED***
            self.navigationBarContentView.topAnchor.constraint(equalTo:view.topAnchor),
            self.navigationBarContentView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            self.navigationBarContentView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            self.navigationBarContentView.heightAnchor.constraint(equalToConstant:UIDefines.Sizes.navigationBarContentViewHeight),
            
            self.navigationBarLargeTitleView.topAnchor.constraint(equalTo:self.navigationBarContentView.bottomAnchor),
            self.navigationBarLargeTitleView.leadingAnchor.constraint(equalTo:view.leadingAnchor),
            self.navigationBarLargeTitleView.trailingAnchor.constraint(equalTo:view.trailingAnchor),
            self.navigationBarLargeTitleView.heightAnchor.constraint(equalToConstant:UIDefines.Sizes.navigationBarLargeTitleViewHeight),
            
***REMOVED***)
        return view
    }()
    
    fileprivate lazy var navigationBarLargeTitleView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIDefines.Colors.navigationBarTintColor
        view.addSubview(self.navigationBarLargeTitleLabel)
        view.addConstraints(***REMOVED***
            self.navigationBarLargeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.navigationBarLargeTitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:-UIDefines.Spacings.singleUnit),
            self.navigationBarLargeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit)
***REMOVED***)
        return view
    }()
    
    fileprivate lazy var navigationBarContentView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIDefines.Colors.navigationBarTintColor
        return view
    }()
    
    fileprivate lazy var navigationBarLargeTitleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIDefines.Fonts.navigationBarLargeTitleViewTitle
        label.text = UIDefines.Copies.saturdaysTitle
        label.textColor = UIDefines.Colors.black
        return label
    }()
    
    //MARK: Lifecycle
    init(presenter:IssueListPresenter, imageDownloadService:ImageDownloadService) {
        self.presenter = presenter
        if #available(iOS 11.0, *) {
            self.osVersion = .eleven
        } else {
            self.osVersion = .ten
        }
        self.imageDownloadService = imageDownloadService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = UIDefines.Copies.saturdaysTitle
        self.setupTableView()
        self.addSubviews()
        self.setupLayoutConstraints()
        self.presenter.retrieveIssues()
    }
    
    //MARK: Private
    fileprivate func setupTableView() {
        self.tableView.dataSource = self.tableViewDataSource
        self.tableView.delegate = self.tableViewDataSource
        self.tableView.prefetchDataSource = self.tableViewDataSource
    }
    
    fileprivate func addSubviews() {
            self.view.addSubview(self.tableView)
        self.view.addSubview(self.loadingIndicator)
        if osVersion == .ten {
            self.view.addSubview(self.navigationBarView)
        }
    }
    
    fileprivate func setupLayoutConstraints() {
        var topAnchor : NSLayoutYAxisAnchor
        if osVersion == .ten {
            topAnchor = self.navigationBarView.bottomAnchor
        } else {
            topAnchor = self.view.topAnchor
        }
        
        var constraints : ***REMOVED***NSLayoutConstraint***REMOVED*** = ***REMOVED***
            loadingIndicator.topAnchor.constraint(equalTo: topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
***REMOVED***
        
        if osVersion == .ten {
            constraints.append(contentsOf: ***REMOVED***
                navigationBarView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
                navigationBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                navigationBarView.heightAnchor.constraint(equalToConstant: UIDefines.Sizes.navigationBarViewHeight),
                navigationBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ***REMOVED***)
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    fileprivate func handleSelection(with conf:IssueListViewDataSourceSelection) {
        self.selectedIndexPath = conf.indexPath
        
        let detailView = self.presenter.getDetailView(for: conf)
//        detailView.transitioningDelegate = self
        DispatchQueue.main.async {
            self.present(detailView, animated: true, completion: nil)
        }
    }
}

extension IssueListView : IssueListViewProtocol {
    func showLoadingIndicator() {
        self.loadingIndicator.isHidden = false
        self.tableView.isHidden = true
    }
    
    func hideLoadingIndicator() {
        self.loadingIndicator.removeFromSuperview()
        self.loadingIndicator.isHidden = true
        self.tableView.isHidden = false
    }
    
    func showError(message:String) {
        print(message)
    }
    
    func show(issues:***REMOVED***IssueViewModel***REMOVED***) {
        self.tableViewDataSource.update(with: issues)
        self.tableView.reloadData()
    }
}

extension IssueListView : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let cell = self.tableView.cellForRow(at: selectedIndexPath) as? IssueListCell else { return nil }
        
        let sourceRect = self.tableView.convert(cell.frame, to: nil)
        
        self.issueDetailsAnimator.sourceView = cell.issueImageView
        self.issueDetailsAnimator.sourceRect = sourceRect
        self.issueDetailsAnimator.presenting = true
        
        return self.issueDetailsAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
