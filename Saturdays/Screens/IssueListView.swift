//
//  IssueListView.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/11/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueListView: UIViewController {
    
    fileprivate let issueService: IssueService = IssueService()
    fileprivate var issues: ***REMOVED***Issue***REMOVED***? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.issueService.get { (result) in
            switch result {
            case .success(let issues):
                self.issues = issues
                
            case .failure(let error):
                print(error)
***REMOVED***
        }
    }
}

