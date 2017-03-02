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
    
    init(with issue: Issue) {
        let tracksSection = TableViewDataSourceGenericSectionModel<Track, IssueDetailsTrackCell>(items: issue.tracks, reuseIdentifier:IssueDetailsTrackCell.name) { (model, cell) in
        }
        
        let venuesSection = TableViewDataSourceGenericSectionModel<Venue, IssueDetailsVenueCell>(items: issue.venues, reuseIdentifier:IssueDetailsVenueCell.name) { (model, cell) in
        }
        
        let postsSection = TableViewDataSourceGenericSectionModel<Post, IssueDetailsPostCell>(items: issue.posts, reuseIdentifier:IssueDetailsPostCell.name) { (model, cell) in
        }
        
        self.sections = ***REMOVED***tracksSection, venuesSection, postsSection***REMOVED***
    }
    
    init(sections: ***REMOVED***TableViewDataSourceGenericSectionModelProtocol***REMOVED***) {
        self.sections = sections
    }
    
    private func section(at index: Int) -> TableViewDataSourceGenericSectionModelProtocol {
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
}
