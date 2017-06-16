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
    fileprivate let posts : ***REMOVED***PostViewModel***REMOVED***
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate lazy var headerView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        return UIHelper.getTableViewSectionHeader(with: UIDefines.Copies.postsTitle)
    }()
    
    //MARK: Lifecycle
    init(with posts:***REMOVED***PostViewModel***REMOVED***, imageDownloadingService:ImageDownloadingService) {
        self.imageDownloadingService = imageDownloadingService
        self.posts = posts
        super.init()
    }
    
    //MARK: Private
    fileprivate func imageUrls(for indexPaths:***REMOVED***IndexPath***REMOVED***) -> ***REMOVED***URL***REMOVED*** {
        return indexPaths.map({ (indexPath) -> URL in
            return self.posts***REMOVED***indexPath.row***REMOVED***.photoUrl
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
        guard let imageSize = self.posts***REMOVED***indexPath.row***REMOVED***.photoSize else {
            return CGFloat.leastNormalMagnitude
        }
        return imageSize.appropriateSize(for: tableView.frame.size).height
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass.self), for: indexPath) as! IssueDetailsPostCell
        let item = self.posts***REMOVED***indexPath.row***REMOVED***
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
    
    func dataSource(_ tableView: UITableView, prefetchRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        self.imageDownloadingService.prefetch(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        self.imageDownloadingService.cancelPrefetcing(self.imageUrls(for: indexPaths))
    }
    
    func deeplinkUrl(for indexPath: IndexPath) -> URL {
        let item = self.posts***REMOVED***indexPath.row***REMOVED***
        return item.deeplinkURL
    }
}
