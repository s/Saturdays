//
//  IssueDetailsDataSource.swift
//  Saturdays
//
//  Created by Said Ozcan on 14/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

@objc protocol IssueDetailsDataSourceProtocol {
    var cellClass : AnyClass { get }
    func dataSource(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func dataSource(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    @objc optional func dataSource(_ tableView: UITableView, prefetchRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***)
    @objc optional func dataSource(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***)
    @objc optional func dataSource(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    @objc optional func dataSource(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    @objc optional func dataSource(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    @objc optional func deeplinkUrl(for indexPath:IndexPath) -> URL
}

class IssueDetailsDataSource : NSObject {
    
    //MARK: Properties
    fileprivate let dataSources : ***REMOVED***IssueDetailsDataSourceProtocol***REMOVED***
    fileprivate let selectionHandler : (URL) -> ()
    
    //MARK: Lifecycle
    init(with dataSources:***REMOVED***IssueDetailsDataSourceProtocol***REMOVED***, tableView:UITableView, selectionHandler:@escaping (URL)->()) {
        for source in dataSources {
            tableView.register(source.cellClass, forCellReuseIdentifier: String(describing:source.cellClass.self))
        }
        self.dataSources = dataSources
        self.selectionHandler = selectionHandler
        super.init()
    }
    
    //MARK: Fileprivate
    fileprivate func isLast(section:Int) -> Bool {
        return section == self.dataSources.count - 1
    }
    
    fileprivate func groupIndexPathsBySection(indexPaths:***REMOVED***IndexPath***REMOVED***) -> ***REMOVED***Int:***REMOVED***IndexPath***REMOVED******REMOVED*** {
        var groupedIndexPaths : ***REMOVED***Int:***REMOVED***IndexPath***REMOVED******REMOVED*** = ***REMOVED***:***REMOVED***
        for indexPath in indexPaths {
            groupedIndexPaths***REMOVED***indexPath.section***REMOVED***?.append(indexPath)
        }
        return groupedIndexPaths
    }
}

extension IssueDetailsDataSource : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSources.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources***REMOVED***section***REMOVED***.dataSource(tableView, numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.dataSources***REMOVED***indexPath.section***REMOVED***.dataSource(tableView, cellForRowAt:indexPath)
    }
}

extension IssueDetailsDataSource : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let height =  self.dataSources***REMOVED***section***REMOVED***.dataSource?(tableView, heightForHeaderInSection: section) {
            return height
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.dataSources***REMOVED***section***REMOVED***.dataSource?(tableView, viewForHeaderInSection:section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if !self.isLast(section: section) {
            return UIDefines.Spacings.cellSpacing
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if !self.isLast(section: section) {
            return UIView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = self.dataSources***REMOVED***indexPath.section***REMOVED***.dataSource?(tableView, heightForRowAt:indexPath) {
            return height
        }
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = self.dataSources***REMOVED***indexPath.section***REMOVED***.deeplinkUrl?(for: indexPath) {
            self.selectionHandler(url)
        }
    }
}

extension IssueDetailsDataSource : UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        for (section, subIndexPaths) in self.groupIndexPathsBySection(indexPaths: indexPaths) {
            self.dataSources***REMOVED***section***REMOVED***.dataSource?(tableView, prefetchRowsAt: subIndexPaths)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: ***REMOVED***IndexPath***REMOVED***) {
        for (section, subIndexPaths) in self.groupIndexPathsBySection(indexPaths: indexPaths) {
            self.dataSources***REMOVED***section***REMOVED***.dataSource?(tableView, cancelPrefetchingForRowsAt: subIndexPaths)
        }
    }
}
