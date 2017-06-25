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
    private let credentialsHelper : CredentialsHelper
    
    //MARK: Lifecycle
    init(imageDownloadingService:ImageDownloadingService, credentialsHelper:CredentialsHelper) {
        self.imageDownloadingService = imageDownloadingService
        self.credentialsHelper = credentialsHelper
    }
    
    //MARK: Public
    func createRootViewController() -> UIViewController {
        return self.createIssueListModule()
    }
    
    func createIssueDetailModule(with conf:IssueDetailsOpeningConfiguration) -> UIViewController {
        let presenter = IssueDetailsPresenter(with:self)
        let view = IssueDetailsView(with: presenter,
                                    item:conf.item,
                                    issueImage:conf.image,
                                    imageDownloadingService:self.imageDownloadingService)
        presenter.view = view
        return view
    }
    
    func openIssueForRemoteNotification(number issueNumber:Int) -> UIViewController {
        return self.createIssueListModule(needsToOpenIssueNumber: issueNumber)
    }
    
    //MARK: Private
    fileprivate func createIssueListModule(needsToOpenIssueNumber issueNumber:Int?=nil) -> UIViewController {
        
        let issueService = IssueService(credentialsHelper: credentialsHelper)
        let presenter = IssueListPresenter(issueService:issueService, routingService:self)
        let issueListView =  IssueListView(presenter: presenter,
                                           imageDownloadingService: imageDownloadingService,
                                           needsToOpenIssueNumber:issueNumber)
        
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
        navigationController.navigationBar.tintColor = Defines.Colors.navigationBarTintColor
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        return navigationController
    }
}
