//
//  IssueDetailsSectionProtocol.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

protocol IssueDetailsSectionProtocol : class {
    func issueDetails(itemWasSelected item: ExternallyOpenable, in section: TableViewDataSourceGenericSectionModelProtocol)
}
