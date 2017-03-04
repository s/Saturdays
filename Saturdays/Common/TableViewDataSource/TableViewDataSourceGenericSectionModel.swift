//
//  TableViewDataSourceGenericSectionModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Foundation

class TableViewDataSourceGenericSectionModel<Cell, Model>: NSObject, TableViewDataSourceGenericSectionModelProtocol where Cell: UITableViewCell, Cell: ConfigurableCell, Model: ImageDownloadableModel, Cell.Model == Model {
    private let items: ***REMOVED***Model***REMOVED***
    private let reuseIdentifier: String
    
    init(items: ***REMOVED***Model***REMOVED***, reuseIdentifier:String) {
        self.items = items
        self.reuseIdentifier = reuseIdentifier
    }
    
    func sectionModel(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func sectionModel(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! Cell
        let item = items***REMOVED***indexPath.row***REMOVED***
        cell.configure(with: item)
        
        self.download(cellImage: item.imageURL,
                      downloadProgressHandler: { (progress) in
                        cell.updateCellImageDownloadStatus(with: progress.fractionCompleted)
        }) { (response) in
            if let image = response.result.value {
                cell.updateCell(with: image)
***REMOVED***
        }
        
        return cell
    }
    
    func sectionModel(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.items***REMOVED***indexPath.row***REMOVED***
        let cell = self.sectionModel(tableView, cellForRowAt: indexPath)
        self.selectHandler(cell: cell as! Cell, model: model)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func sectionModel(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let defaultSectionHeight : CGFloat = 40.0
        return defaultSectionHeight
    }
    
    func sectionModel(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func sectionModel(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight  
    }
    
    internal func selectHandler(cell: Cell, model: Model) {}
}
