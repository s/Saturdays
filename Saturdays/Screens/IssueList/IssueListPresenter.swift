//
//  IssueListPresenter.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

class IssueListPresenter : NSObject {
    
    fileprivate let service : IssueService
    weak var view : IssueListView?
    
    init(with service:IssueService) {
        self.service = service
        super.init()
    }
    
    func retrieveIssues() {
        self.view?.showLoadingIndicator()
        
        service.get { ***REMOVED***unowned self***REMOVED*** (result) in
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
    
    fileprivate func createViewModels(from issues:***REMOVED***Issue***REMOVED***) -> ***REMOVED***IssueViewModel***REMOVED*** {
        return issues.map { (issue) -> IssueViewModel in
            return IssueViewModel(with: issue)
        }
    }
}
