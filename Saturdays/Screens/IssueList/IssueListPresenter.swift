//
//  IssueListPresenter.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueListPresenter : NSObject {
    
    fileprivate let routingService : RoutingService
    fileprivate let issueService : IssueService
    weak var view : IssueListView?
    
    //MARK: Lifecycle
    init(issueService:IssueService, routingService:RoutingService) {
        self.issueService = issueService
        self.routingService = routingService
        super.init()
    }
    
    
    //MARK: Public Interface
    func retrieveIssues() {
        self.view?.showLoadingIndicator()
        
        issueService.get { ***REMOVED***unowned self***REMOVED*** (result) in
            self.view?.hideLoadingIndicator()
            
            switch (result) {
            case .success(let issues):
                let viewModels = self.createViewModels(from: issues)
                self.view?.show(issues: viewModels)
                
            case .failure(let error):
                self.view?.showError(message: error.localizedDescription)
***REMOVED***
        }
    }
    
    func getDetailView(for conf:IssueListViewDataSourceSelection) -> UIViewController {
        return self.routingService.createIssueDetailModule(with: conf)
    }
    
    //MARK: Private
    fileprivate func createViewModels(from issues:***REMOVED***Issue***REMOVED***) -> ***REMOVED***IssueViewModel***REMOVED*** {
        return issues.map { (issue) -> IssueViewModel in
            return IssueViewModel(with: issue)
        }
    }
}
