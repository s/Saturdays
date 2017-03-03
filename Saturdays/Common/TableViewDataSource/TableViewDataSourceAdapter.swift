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
    let sections: ***REMOVED***TableViewDataSourceGenericSectionModelProtocol***REMOVED***
    
    init(sections: ***REMOVED***TableViewDataSourceGenericSectionModelProtocol***REMOVED***) {
        self.sections = sections
    }
    
    fileprivate func section(at index: Int) -> TableViewDataSourceGenericSectionModelProtocol {
        return self.sections***REMOVED***index***REMOVED***
    }
}

extension TableViewDataSourceAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(at: section).sectionModel(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.section(at: indexPath.section).sectionModel(tableView, cellForRowAt: indexPath)
    }
}

extension TableViewDataSourceAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return self.section(at: indexPath.section).sectionModel(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.section(at: section).sectionModel(tableView, heightForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.section(at: section).sectionModel(tableView, viewForHeaderInSection: section)
    }
}
