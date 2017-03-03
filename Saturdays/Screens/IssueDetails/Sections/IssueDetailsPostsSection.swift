//
//  IssueDetailsPostsSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostsSection: TableViewDataSourceGenericSectionModel<IssueDetailsPostCell, Post> {
    
    weak var delegate: IssueDetailsSectionProtocol?
    
    init(with items:***REMOVED***Post***REMOVED***) {
        super.init(items: items, reuseIdentifier: IssueDetailsPostCell.name)
    }
    
    override func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableHeaderView(with: .post)
    }
    
    override func selectHandler(cell: IssueDetailsPostCell, model: Post) {
        self.delegate?.issueDetails(itemWasSelected: model, in: self)
    }
}
