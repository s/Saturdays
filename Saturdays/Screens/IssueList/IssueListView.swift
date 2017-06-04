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

class IssueListView : UIViewController {
    
    //MARK: Properties
    fileprivate let presenter : IssueListPresenter
    fileprivate lazy var tableViewDataSource : IssueListViewDataSource = { ***REMOVED***unowned self***REMOVED*** in
        return IssueListViewDataSource(with: self.tableView,
                                       imageDownloadService:self.imageDownloadService)
    }()
    fileprivate lazy var imageDownloadService : ImageDownloadService = {
        return ImageDownloadService()
    }()
    
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
        tableView.estimatedRowHeight = 250.0
        return tableView
    }()
    
    //MARK: Lifecycle
    init(with presenter:IssueListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SATURDAYS"
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
        self.view.addSubview(self.loadingIndicator)
        self.view.addSubview(self.tableView)
    }
    
    fileprivate func setupLayoutConstraints() {
        let constraints : ***REMOVED***NSLayoutConstraint***REMOVED*** = ***REMOVED***
            loadingIndicator.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
***REMOVED***
        NSLayoutConstraint.activate(constraints)
    }
}

extension IssueListView : IssueListViewProtocol {
    func showLoadingIndicator() {
        self.loadingIndicator.isHidden = false
        self.tableView.isHidden = true
    }
    
    func hideLoadingIndicator() {
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
