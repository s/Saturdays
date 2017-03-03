//
//  IssueDetailsTracksSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTracksSection: TableViewDataSourceGenericSectionModel<IssueDetailsTrackCell, Track> {
    
    weak var delegate: IssueDetailsSectionProtocol?
    
    init(with items:***REMOVED***Track***REMOVED***) {
        super.init(items: items, reuseIdentifier: IssueDetailsTrackCell.name)
    }
    
    override func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableHeaderView(with: .track)
    }
    
    override func selectHandler(cell: IssueDetailsTrackCell, model: Track) {
        self.delegate?.issueDetails(itemWasSelected: model, in: self)
    }
}
