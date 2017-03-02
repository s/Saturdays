//
//  TableViewDataSourceGenericSectionModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Foundation

class TableViewDataSourceGenericSectionModel<Model, Cell>: TableViewDataSourceGenericSectionModelProtocol where Cell: UITableViewCell, Cell: ConfigurableCell, Cell.Model == Model {
    private let items: ***REMOVED***Model***REMOVED***
    private let reuseIdentifier: String
    private let selectionHandler: (Cell, Model) -> ()
    
    init(items: ***REMOVED***Model***REMOVED***, reuseIdentifier:String, selectionHandler: @escaping (Cell, Model) -> ()) {
        self.items = items
        self.selectionHandler = selectionHandler
        self.reuseIdentifier = reuseIdentifier
    }
    
    func sectionModel(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func sectionModel(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! Cell
        cell.configure(with: items***REMOVED***indexPath.row***REMOVED***)
        return cell
    }
    
    func sectionModel(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.items***REMOVED***indexPath.row***REMOVED***
        let cell = self.sectionModel(tableView, cellForRowAt: indexPath)
        self.selectionHandler(cell as! Cell, model)
    }
}
