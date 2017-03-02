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

        self.updateSubviews()
        self.registerCells()
        self.issueTableView.dataSource = self.dataSource
        self.issueTableView.tableFooterView = UIView()
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
        self.dataSource = TableViewDataSourceAdapter(with: issue)
        super.init(nibName: IssueDetailsView.name, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Helpers
    
    private func updateSubviews() {
        self.headingLabel.text = self.issue.detailHeading
        self.descriptionLabel.text = self.issue.detailDescription
    }
    
    private func registerCells() {
        self.issueTableView.register(nib: IssueDetailsTrackCell.self)
        self.issueTableView.register(nib: IssueDetailsVenueCell.self)
        self.issueTableView.register(nib: IssueDetailsPostCell.self)
    }
}
