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

class IssueListViewDataSource : NSObject {
    fileprivate var items : [IssueViewModel] = []
    fileprivate let tableView : UITableView
    fileprivate let selectHandler : (IssueDetailsOpeningConfiguration) -> Void
    fileprivate let cellIdentifier = String(describing: IssueListCell.self)
    fileprivate let imageDownloadingService : ImageDownloadingService
    
    init(with tableView:UITableView,
         imageDownloadingService:ImageDownloadingService,
         selectHandler:@escaping (IssueDetailsOpeningConfiguration) -> Void) {
        self.tableView = tableView
        self.selectHandler = selectHandler
        self.imageDownloadingService = imageDownloadingService
        self.tableView.register(IssueListCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    func update(with items:[IssueViewModel]) {
        self.items = items
    }
    
    func selectionConfiguration(for indexPath:IndexPath) -> IssueDetailsOpeningConfiguration? {
        let item = self.items[indexPath.section]
        guard let cell = self.tableView(self.tableView, cellForRowAt: indexPath) as? IssueListCell else { return nil }
        
        return IssueDetailsOpeningConfiguration(indexPath: indexPath,
                                                item: item,
                                                image: cell.issueImageView.image)
    }
    
    func getIssue(number issueNumber:Int) -> IssueViewModel? {
        return self.items.filter { (viewModel) -> Bool in
            return viewModel.number == issueNumber
        }.first
    }
    
    // MARK : Private
    fileprivate func imageURL(at indexPath:IndexPath) -> URL? {
        let item = self.items[indexPath.section]
        return item.photoURL
    }
    
    fileprivate func imageUrls(for indexPaths:[IndexPath]) -> [URL] {
        var urls : [URL] = []
        for indexPath in indexPaths {
            if let url = self.imageURL(at: indexPath) {
                urls.append(url)
            }
        }
        return urls
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
        cell.configure(with: self.items[indexPath.section])
        if let imageURL = self.imageURL(at: indexPath) {
            cell.issueImageView.af_setImage(withURL: imageURL)
        }
        return cell
    }
}

extension IssueListViewDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageSize = self.items[indexPath.row].photoSize
        return imageSize.appropriateSize(for: self.tableView.frame.size).height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Defines.spacings.cellSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == self.items.count - 1 {
            return Defines.spacings.cellSpacing
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
        guard let conf = self.selectionConfiguration(for: indexPath) else { return }
        self.selectHandler(conf)
    }
}

extension IssueListViewDataSource : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.prefetch(self.imageUrls(for: indexPaths))
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.cancelPrefetcing(self.imageUrls(for: indexPaths))
    }
}
