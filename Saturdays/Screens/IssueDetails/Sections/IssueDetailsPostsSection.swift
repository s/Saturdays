//
//  IssueDetailsPostsSection.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostsSection: TableViewDataSourceGenericSectionModel<IssueDetailsPostCell, Post> {
    
    let items: ***REMOVED***Post***REMOVED***
    weak var delegate: IssueDetailsSectionProtocol?
    
    init(with items:***REMOVED***Post***REMOVED***) {
        self.items = items
        super.init(items: items, reuseIdentifier: IssueDetailsPostCell.name)
    }
    
    override func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return TableHeaderView(with: .post)
    }
    
    override func sectionModel(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let imageSize = self.items***REMOVED***indexPath.row***REMOVED***.photo.size else {
            return super.sectionModel(tableView, heightForRowAt: indexPath)
        }
        let imageHeight = ( tableView.frame.size.width * imageSize.height ) / imageSize.width
        let bottomSpacing: CGFloat = 1
        return imageHeight + bottomSpacing
    }
    
    override func selectHandler(cell: IssueDetailsPostCell, model: Post) {
        self.delegate?.issueDetails(itemWasSelected: model, in: self)
    }
}
