//
//  TableViewDataSourceGenericSectionModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/2/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

protocol TableViewDataSourceGenericSectionProtocol: NSObjectProtocol {
    associatedtype Cell: ConfigurableCell
    
    var items: ***REMOVED***Cell.Model***REMOVED*** { get }
    var reuseIdentifier: String { get }
    weak var delegate: IssueDetailsSectionProtocol? { get }
}

extension TableViewDataSourceGenericSectionProtocol {
    
    func genericSection(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func genericSection(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Cell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! Cell
        let item = items***REMOVED***indexPath.row***REMOVED***
        cell.configure(with: item)
        
        Alamofire.request(item.imageURL).downloadProgress(closure: { (progress) in
            cell.updateCellImageDownloadStatus(with: progress.fractionCompleted)
        }).responseImage { (response) in
            if let image = response.result.value {
                cell.updateCell(with: image)
***REMOVED***

        }

        return cell
    }
    
    func genericSection(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.items***REMOVED***indexPath.row***REMOVED***
        self.delegate?.issueDetails(itemWasSelected: model)        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func genericSection(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let defaultSectionHeaderHeight : CGFloat = 44.0
        return defaultSectionHeaderHeight
    }
    
    func genericSection(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func genericSection(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}
