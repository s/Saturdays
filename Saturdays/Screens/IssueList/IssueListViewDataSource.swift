//
//  IssueListViewDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 03/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct IssueListViewDataSourceSelection {
    let indexPath:IndexPath
    let item:IssueViewModel
    let image:UIImage?
}

class IssueListViewDataSource : NSObject {
    fileprivate var items : ***REMOVED***IssueViewModel***REMOVED*** = ***REMOVED******REMOVED***
    fileprivate let tableView : UITableView
    fileprivate let selectHandler : (IssueListViewDataSourceSelection) -> Void
    fileprivate let cellIdentifier = String(describing: IssueListCell.self)
    fileprivate let imageDownloadService : ImageDownloadService
    
    init(with tableView:UITableView,
         imageDownloadService:ImageDownloadService,
         selectHandler:@escaping (IssueListViewDataSourceSelection) -> Void) {
        self.tableView = tableView
        self.selectHandler = selectHandler
        self.imageDownloadService = imageDownloadService
        self.tableView.register(IssueListCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    func update(with items:***REMOVED***IssueViewModel***REMOVED***) {
        self.items = items
    }
    
    // MARK : Private
    fileprivate func imageURL(at indexPath:IndexPath) -> URL? {
        let item = self.items***REMOVED***indexPath.section***REMOVED***
        return item.photoURL
    }
}

extension IssueListViewDataSource : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! IssueListCell
        cell.configure(with: self.items***REMOVED***indexPath.section***REMOVED***)
        if let imageURL = self.imageURL(at: indexPath) {
            cell.issueImageView.af_setImage(withURL: imageURL)
        }
        return cell
    }
}

extension IssueListViewDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenWidth = self.tableView.frame.size.width
        
        guard let imageSize = self.items***REMOVED***indexPath.row***REMOVED***.photoSize else {
            return UIDefines.Sizes.defaultIssueCellHeight
        }
        
        let cellHeight = ( screenWidth * imageSize.height ) / imageSize.width
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDefines.Spacings.cellSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.items.count - 1 {
            return UIDefines.Spacings.cellSpacing
        }
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == self.items.count - 1 {
            return UIView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.items***REMOVED***indexPath.section***REMOVED***
        let cell = self.tableView.cellForRow(at: indexPath) as! IssueListCell
        let conf = IssueListViewDataSourceSelection(indexPath: indexPath,
                                                    item: item,
                                                    image: cell.issueImageView.image)
        self.selectHandler(conf)
    }
}

extension IssueListViewDataSource : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        for indexPath in indexPaths {
            guard let url = self.imageURL(at: indexPath) else { continue }
            DispatchQueue.global(qos: .background).async {
                self.imageDownloadService.download(cellImage: url,
                                                   downloadProgressHandler: nil,
                                                   completionHandler: nil)
***REMOVED***
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        for indexPath in indexPaths {
            guard let url = self.imageURL(at: indexPath) else { continue }
            DispatchQueue.global(qos: .background).async {
                self.imageDownloadService.cancel(downloading: url)
***REMOVED***
        }
    }
}
