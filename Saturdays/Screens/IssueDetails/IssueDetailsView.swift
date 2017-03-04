//
//  IssueDetailsView.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/12/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsView: UIViewController {
    
    fileprivate let issue: Issue
    fileprivate let dataSource: TableViewDataSourceAdapter
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var issueTableView: UITableView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        self.updateSubviews()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    init(with issue:Issue) {
        self.issue = issue
        
        let tracksSection = IssueDetailsTracksSection(with: issue.tracks)
        let venuesSection = IssueDetailsVenuesSection(with: issue.venues)
        let postsSection = IssueDetailsPostsSection(with: issue.posts)
        
        let sections: ***REMOVED***TableViewDataSourceGenericSectionModelProtocol***REMOVED*** = ***REMOVED***tracksSection,
                                                                          venuesSection,
                                                                          postsSection***REMOVED***
        self.dataSource = TableViewDataSourceAdapter(sections: sections)
        
        super.init(nibName: IssueDetailsView.name, bundle: nil)
        
        tracksSection.delegate = self
        venuesSection.delegate = self
        postsSection.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    fileprivate func updateSubviews() {
        self.headingLabel.text = self.issue.detailHeading
        self.descriptionLabel.text = self.issue.detailDescription
    }
    
    fileprivate func registerCells() {
        self.issueTableView.register(nib: IssueDetailsTrackCell.self)
        self.issueTableView.register(nib: IssueDetailsVenueCell.self)
        self.issueTableView.register(nib: IssueDetailsPostCell.self)
    }
    
    fileprivate func setupTableView() {
        self.issueTableView.estimatedRowHeight = 76.0
        self.issueTableView.rowHeight = UITableViewAutomaticDimension
        
        self.issueTableView.sizeHeaderToFit()
        self.issueTableView.tableFooterView = UIView()
        
        self.registerCells()
        self.issueTableView.dataSource = self.dataSource
        self.issueTableView.delegate = self.dataSource
    }
    
    // MARK: Actions
    
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

extension IssueDetailsView : IssueDetailsSectionProtocol {
    func issueDetails(itemWasSelected item: ExternallyOpenable, in section: TableViewDataSourceGenericSectionModelProtocol) {
        print(item, section)
    }
}
