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
    func createRootViewController() -> UIViewController {
        return self.createIssueListModule()
    }
    
    func createIssueListModule() -> UIViewController {
        let issueService = IssueService()
        let presenter = IssueListPresenter(with:issueService)
        let issueListView =  IssueListView(with: presenter)
        
        presenter.view = issueListView
        
        let navigationController = UINavigationController(rootViewController: issueListView)
        return navigationController
    }
}
