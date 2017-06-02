//
//  TableViewDataSourceAdapter.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSourceAdapter: NSObject {
    let sections: ***REMOVED***TableViewDataSourceProtocol***REMOVED***
    
    init(sections: ***REMOVED***TableViewDataSourceProtocol***REMOVED***) {
        self.sections = sections
    }
    
    fileprivate func section(at index: Int) -> TableViewDataSourceProtocol {
        return self.sections***REMOVED***index***REMOVED***
    }
}

extension TableViewDataSourceAdapter : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(at: section).dataSource(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.section(at: indexPath.section).dataSource(tableView, cellForRowAt: indexPath)
    }
}

extension TableViewDataSourceAdapter : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.section(at: indexPath.section).dataSource(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.section(at: section).dataSource(tableView, heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.section(at: section).dataSource(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.section(at: indexPath.section).dataSource(tableView, heightForRowAt: indexPath)
    }
}
