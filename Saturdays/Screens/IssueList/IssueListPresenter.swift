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
        
        issueService.get { [weak self] (result) in
            guard let strongSelf = self else { return }
            strongSelf.view?.hideLoadingIndicator()
            
            switch (result) {
            case .success(let issues):
                let viewModels = strongSelf.createViewModels(from: issues)
                strongSelf.view?.show(issues: viewModels)
                
            case .failure(let error):
                strongSelf.view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func getDetailView(for conf:IssueDetailsOpeningConfiguration) -> UIViewController {
        return self.routingService.createIssueDetailModule(with: conf)
    }
    
    func getDetailView(for viewModel:IssueViewModel) -> UIViewController {
        let conf = IssueDetailsOpeningConfiguration(indexPath: nil,
                                                    item: viewModel,
                                                    image: nil)
        return self.getDetailView(for: conf)
    }
    
    //MARK: Private
    fileprivate func createViewModels(from issues:[Issue]) -> [IssueViewModel] {
        return issues.map { (issue) -> IssueViewModel in
            return IssueViewModel(with: issue)
        }
    }
}
