//
//  IssueDetailsView.swift
//  Saturdays
//
//  Created by Said Ozcan on 05/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsView: UIViewController {
    
    //MARK: Properties
    public var imageViewFrame : CGRect {
        get {
            return self.imageView.frame
        }
        set {
            
        }
    }
    fileprivate let item : IssueViewModel
    fileprivate let presenter : IssueDetailsPresenter
    fileprivate let issueImage : UIImage?
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate lazy var dataSource : IssueDetailsDataSource = { ***REMOVED***unowned self***REMOVED*** in
        return IssueDetailsDataSource(with:self.childDataSources, tableView:self.tableView)
    }()
    fileprivate lazy var childDataSources : ***REMOVED***IssueDetailsDataSourceProtocol***REMOVED*** = { ***REMOVED***unowned self***REMOVED*** in
        var dataSources : ***REMOVED***IssueDetailsDataSourceProtocol***REMOVED*** = ***REMOVED***
            IssueDetailsTitleDataSource(with:self.item),
            IssueDetailsTracksDataSource(with: self.item.tracks,
                                         imageDownloadingService: self.imageDownloadingService),
            IssueDetailsVenuesDataSource(with: self.item.venues,
                                         imageDownloadingService: self.imageDownloadingService),
***REMOVED***
        
        if let image = self.issueImage {
            let imageDataSource = IssueDetailsImageDataSource(with:image)
            dataSources.insert(imageDataSource, at: 1)
        }
        return dataSources
    }()
    
    //MARK: Subviews
    fileprivate lazy var imageView : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = self.issueImage
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = UIDefines.Sizes.issueListCellCornerRadius
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    fileprivate lazy var dismissIcon : UIImageView = { ***REMOVED***unowned self***REMOVED*** in
        let imageView = UIImageView(image: Images.dismissIcon)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    fileprivate lazy var tableView : UITableView = { ***REMOVED***unowned self***REMOVED*** in
        let tableView = UITableView(frame:CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIDefines.Sizes.defaultIssueCellHeight
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: Lifecycle
    override var prefersStatusBarHidden: Bool {
        if isViewLoaded {
            return true
        } else {
            return false
        }
    }
    
    init(with presenter:IssueDetailsPresenter,
         item:IssueViewModel,
         issueImage:UIImage?,
         imageDownloadingService:ImageDownloadingService)
    {
        self.presenter = presenter
        self.item = item
        self.issueImage = issueImage
        self.imageDownloadingService = imageDownloadingService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = item.title
        self.view.backgroundColor = UIDefines.Colors.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.setupLayout()
        self.setupDismissIcon()
        self.setupTableView()
    }
    
    
    //MARK: Private
    fileprivate func setupTableView() {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        self.tableView.prefetchDataSource = dataSource
    }
    
    fileprivate func setupLayout() {
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    fileprivate func addSubviews() {
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.dismissIcon)
    }
    
    fileprivate func setupLayoutConstraints() {
        NSLayoutConstraint.activate(***REMOVED***
            self.dismissIcon.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.dismissIcon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit),
            self.dismissIcon.widthAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsDismissIconDimension),
            self.dismissIcon.heightAnchor.constraint(equalToConstant: UIDefines.Sizes.issueDetailsDismissIconDimension),
            
            self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:UIDefines.Spacings.doubleUnit),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-UIDefines.Spacings.doubleUnit)
***REMOVED***)
    }
    
    fileprivate func setupDismissIcon() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissIssue))
        self.dismissIcon.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func dismissIssue() {
        self.dismiss(animated: true, completion: nil)
    }
}
