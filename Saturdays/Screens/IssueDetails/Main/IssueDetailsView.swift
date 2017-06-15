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
    fileprivate var issueImage : UIImage?
    fileprivate let item : IssueViewModel
    fileprivate let presenter : IssueDetailsPresenter
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate var dataSource : IssueDetailsDataSource?
    fileprivate var childDataSources : ***REMOVED***IssueDetailsDataSourceProtocol***REMOVED*** {
        get {
            return ***REMOVED***
                IssueDetailsTitleDataSource(with:self.item),
                IssueDetailsImageDataSource(with:self.issueImage, imageSize:self.item.photoSize),
                IssueDetailsTracksDataSource(with: self.item.tracks,
                                             imageDownloadingService: self.imageDownloadingService),
                IssueDetailsVenuesDataSource(with: self.item.venues,
                                             imageDownloadingService: self.imageDownloadingService),
                IssueDetailsPostsDataSource(with: self.item.posts,
                                            imageDownloadingService: self.imageDownloadingService)
    ***REMOVED***
        }
    }
    
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
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIDefines.Sizes.defaultIssueCellHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView = nil
        tableView.tableHeaderView = UIView()
        tableView.contentInset = UIEdgeInsets(top: UIDefines.Sizes.issueDetailsTableViewInset, left: 0, bottom: 0, right: 0)
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
        
        self.setupUI()
        self.setupDismissIcon()
        self.setupTableViewDataSources()
        
        self.setupLayout()
        self.downloadIssueImageIfNeeded()
    }
    
    
    //MARK: Private
    fileprivate func setupUI() {
        self.title = item.title
        self.view.backgroundColor = UIDefines.Colors.white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    fileprivate func setupDismissIcon() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissIssue))
        self.dismissIcon.addGestureRecognizer(tapGesture)
    }
    
    fileprivate func setupTableViewDataSources() {
        self.dataSource = IssueDetailsDataSource(with:self.childDataSources,
                                                 tableView:self.tableView)
        
        tableView.dataSource = self.dataSource
        tableView.delegate = self.dataSource
        tableView.prefetchDataSource = self.dataSource
    }
    
    fileprivate func setupLayout() {
        self.addSubviews()
        self.setupLayoutConstraints()
    }
    
    fileprivate func downloadIssueImageIfNeeded() {
        guard nil == self.issueImage, let url = item.photoURL else { return }
        
        self.imageView.af_setImage(withURL: url) { ***REMOVED***unowned self***REMOVED*** response in
            guard let data = response.data else { return }
            
            self.issueImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.setupTableViewDataSources()
                self.tableView.reloadSections(***REMOVED***self.getImageSectionNumber()***REMOVED***,
                                              with: .fade)
***REMOVED***
        }
    }
    
    fileprivate func reloadTableView() {
        self.setupTableViewDataSources()
        self.tableView.reloadData()
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
            
            self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
***REMOVED***)
    }
    
    @objc fileprivate func dismissIssue() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func getImageSectionNumber() -> Int {
        for (index, childDataSource) in self.childDataSources.enumerated() {
            if childDataSource is IssueDetailsImageDataSource {
                return index
***REMOVED***
        }
        fatalError("Image section is not used.")
    }
}
