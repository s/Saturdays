//
//  IssueDetailsPostsDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPostsDataSource : NSObject {
    
    //MARK: Properties
    fileprivate let posts : [PostViewModel]
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate lazy var headerView : UIView = { [unowned self] in
        return UIHelper.getTableViewSectionHeader(with: Defines.Copies.postsTitle)
    }()
    
    //MARK: Lifecycle
    init(with posts:[PostViewModel], imageDownloadingService:ImageDownloadingService) {
        self.imageDownloadingService = imageDownloadingService
        self.posts = posts
        super.init()
    }
    
    //MARK: Private
    fileprivate func imageUrls(for indexPaths:[IndexPath]) -> [URL] {
        return indexPaths.map({ (indexPath) -> URL in
            return self.posts[indexPath.row].photoUrl
        })
    }
}

extension IssueDetailsPostsDataSource : IssueDetailsDataSourceProtocol {
    
    var cellClass: AnyClass {
        return IssueDetailsPostCell.self
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func dataSource(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let imageSize = self.posts[indexPath.row].photoSize else {
            return CGFloat.leastNormalMagnitude
        }
        return imageSize.appropriateSize(for: tableView.frame.size).height
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass.self), for: indexPath) as! IssueDetailsPostCell
        let item = self.posts[indexPath.row]
        cell.postImageView.af_setImage(withURL: item.photoUrl)
        cell.configure(with: item)
        return cell
    }
    
    func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func dataSource(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.prefetch(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.cancelPrefetcing(self.imageUrls(for: indexPaths))
    }
    
    func deeplinkUrl(for indexPath: IndexPath) -> URL {
        let item = self.posts[indexPath.row]
        return item.deeplinkURL
    }
}
