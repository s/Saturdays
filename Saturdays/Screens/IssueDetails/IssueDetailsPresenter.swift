//
//  IssueDetailsPresenter.swift
//  Saturdays
//
//  Created by Said Ozcan on 05/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueDetailsPresenter: NSObject {
    
    var view : IssueDetailsView?
    fileprivate let routingService : RoutingService
    
    init(with routingService:RoutingService) {
        self.routingService = routingService
        super.init()
    }

}
