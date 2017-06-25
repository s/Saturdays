//
//  IssueDetailsVenuesDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsVenuesDataSource : NSObject {
    
    //MARK: Properties
    fileprivate let venues : [VenueViewModel]
    fileprivate let imageDownloadingService : ImageDownloadingService
    fileprivate lazy var headerView : UIView = { [unowned self] in
        return UIHelper.getTableViewSectionHeader(with: Defines.Copies.venuesTitle)
    }()
    
    //MARK: Lifecycle
    init(with venues:[VenueViewModel], imageDownloadingService:ImageDownloadingService) {
        self.imageDownloadingService = imageDownloadingService
        self.venues = venues
        super.init()
    }
    
    //MARK: Private
    fileprivate func imageUrls(for indexPaths:[IndexPath]) -> [URL] {
        return indexPaths.map({ (indexPath) -> URL in
            return self.venues[indexPath.row].photoUrl
        })
    }
}

extension IssueDetailsVenuesDataSource : IssueDetailsDataSourceProtocol {
    
    var cellClass: AnyClass {
        return IssueDetailsTitleSubtitleArtworkCell.self
    }
    
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }
    
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:cellClass.self), for: indexPath) as! IssueDetailsTitleSubtitleArtworkCell
        let item = self.venues[indexPath.row]
        cell.mediaImageView.af_setImage(withURL: item.photoUrl)
        cell.configure(with: UIHelper.getVenueCellLabels(for: item))
        return cell
    }
    
    func dataSource(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.prefetch(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        self.imageDownloadingService.cancelPrefetcing(self.imageUrls(for: indexPaths))
    }
    
    func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }
    
    func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    func deeplinkUrl(for indexPath: IndexPath) -> URL {
        return self.venues[indexPath.row].deeplinkURL
    }
}

