//
//  IssueDetailsHeaderDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 14/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTitleDataSource {
    
    //MARK: Properties
    fileprivate let issue : IssueViewModel
    
    required init(with issue: IssueViewModel) {
        self.issue = issue
    }
    
}

extension IssueDetailsTitleDataSource : IssueDetailsDataSourceProtocol {
    
    var cellClass: AnyClass {
        return IssueDetailsTitleCell.self
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass), for: indexPath) as! IssueDetailsTitleCell
        cell.configure(with:issue)
        return cell
    }
}
