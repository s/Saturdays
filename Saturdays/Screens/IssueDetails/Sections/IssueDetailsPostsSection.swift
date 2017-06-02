//
//  IssueDetailsPostsSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostsSection: NSObject, TableViewDataSourceGenericSectionProtocol, TableViewDataSourceProtocol {
    
    typealias Cell = IssueDetailsPostCell
    let items: ***REMOVED***Post***REMOVED***
    weak var delegate: IssueDetailsSectionProtocol?
    var reuseIdentifier: String { return IssueDetailsPostCell.name }
    
    init(items:***REMOVED***Post***REMOVED***) {
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
        guard let imageSize = self.items***REMOVED***indexPath.row***REMOVED***.photo.size else {
            return genericSection(tableView, heightForRowAt: indexPath)
        }
        let imageHeight = ( tableView.frame.size.width * imageSize.height ) / imageSize.width
        let bottomSpacing: CGFloat = 1
        return imageHeight + bottomSpacing
    }
}
