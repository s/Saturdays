//
//  IssueDetailsTracksSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTracksSection: NSObject, TableViewDataSourceGenericSectionProtocol, TableViewDataSourceProtocol {
    
    typealias Cell = IssueDetailsTrackCell
    let items: ***REMOVED***Track***REMOVED***
    weak var delegate: IssueDetailsSectionProtocol?
    var reuseIdentifier: String { return IssueDetailsTrackCell.name }
    
    init(items: ***REMOVED***Track***REMOVED***) {
        self.items = items
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genericSection(tableView, numberOfRowsInSection: section)
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return genericSection(tableView, cellForRowAt: indexPath)
    }
    
    func dataSource(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genericSection(tableView, didSelectRowAt: indexPath)
    }
    
    func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return genericSection(tableView, heightForHeaderInSection: section)
    }
    
    func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableHeaderView(with: .track)
    }
    
    func dataSource(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return genericSection(tableView, heightForRowAt: indexPath)
    }
}
