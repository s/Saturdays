//
//  IssueDetailsTracksDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 13/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsTracksDataSource : NSObject {
    
    //MARK: Properties
    fileprivate let tracks : ***REMOVED***TrackViewModel***REMOVED***
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate lazy var headerView : UIView = { ***REMOVED***unowned self***REMOVED*** in
        return UIHelper.getTableViewSectionHeader(with: UIDefines.Copies.tracksTitle)
    }()
    
    //MARK: Lifecycle
    init(with tracks:***REMOVED***TrackViewModel***REMOVED***, imageDownloadingService:ImageDownloadingService) {
        self.imageDownloadingService = imageDownloadingService
        self.tracks = tracks
        super.init()
    }
    
    //MARK: Private
    fileprivate func imageUrls(for indexPaths:***REMOVED***IndexPath***REMOVED***) -> ***REMOVED***URL***REMOVED*** {
        return indexPaths.map({ (indexPath) -> URL in
            return self.tracks***REMOVED***indexPath.row***REMOVED***.albumArtUrl
        })
    }
}

extension IssueDetailsTracksDataSource : IssueDetailsDataSourceProtocol {
    
    var cellClass: AnyClass {
        return IssueDetailsTitleSubtitleArtworkCell.self
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass.self), for: indexPath) as! IssueDetailsTitleSubtitleArtworkCell
        let item = self.tracks***REMOVED***indexPath.row***REMOVED***
        cell.mediaImageView.af_setImage(withURL: item.albumArtUrl)
        cell.configure(with: UIHelper.getTrackCellLabels(for: item))
        return cell
    }
    
    func dataSource(_ tableView: UITableView, prefetchRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        self.imageDownloadingService.prefetch(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        self.imageDownloadingService.cancelPrefetcing(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    func deeplinkUrl(for indexPath: IndexPath) -> URL {
        return self.tracks***REMOVED***indexPath.row***REMOVED***.deeplinkURL
    }
}
