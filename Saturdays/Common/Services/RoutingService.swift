//
//  RoutingService.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Foundation

class RoutingService {
    
    //MARK: Properties
    fileprivate let imageDownloadingService : ImageDownloadingService
    
    //MARK: Lifecycle
    init(imageDownloadingService:ImageDownloadingService) {
        self.imageDownloadingService = imageDownloadingService
    }
    
    //MARK: Public
    func createRootViewController() -> UIViewController {
        return self.createIssueListModule()
    }
    
    func createIssueDetailModule(with conf:IssueListViewDataSourceSelection) -> UIViewController {
        let presenter = IssueDetailsPresenter(with:self)
        let view = IssueDetailsView(with: presenter,
                                    item:conf.item,
                                    issueImage:conf.image,
                                    imageDownloadingService:self.imageDownloadingService)
        presenter.view = view
        return view
    }
    
    //MARK: Private
    fileprivate func createIssueListModule() -> UIViewController {
        
        let issueService = IssueService()
        let presenter = IssueListPresenter(issueService:issueService, routingService:self)
        let issueListView =  IssueListView(presenter: presenter, imageDownloadingService: imageDownloadingService)
        
        presenter.view = issueListView
        
        if #available(iOS 11.0, *) {
            return self.createNavigationController(with: issueListView)
        } else {
            return issueListView
        }
    }
    
    fileprivate func createNavigationController(with rootView:UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.tintColor = UIDefines.Colors.navigationBarTintColor
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        return navigationController
    }
}
