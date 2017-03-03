//
//  IssueDetailsVenuesSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsVenuesSection: TableViewDataSourceGenericSectionModel<IssueDetailsVenueCell, Venue> {
    
    weak var delegate: IssueDetailsSectionProtocol?
    
    init(with items:***REMOVED***Venue***REMOVED***) {
        super.init(items: items, reuseIdentifier: IssueDetailsVenueCell.name)
    }
    
    override func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableHeaderView(with: .venue)
    }
    
    override func selectHandler(cell: IssueDetailsVenueCell, model: Venue) {
        self.delegate?.issueDetails(itemWasSelected: model, in: self)
    }
}
