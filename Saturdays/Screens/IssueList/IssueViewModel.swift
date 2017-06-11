//
//  IssueListViewModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class IssueViewModel : NSObject, ViewModelProtocol {
    
    // MARK : Properties
    let title : String
    let detailTitle : String
    let detailDescription : String
    let photoURL : URL?
    let photoSize: CGSize?
    
    fileprivate let issue : Issue
    
    // MARK : Lifecycle
    init(with issue:Issue) {
        self.issue = issue
        self.title = issue.title
        self.detailTitle = issue.detailHeading
        self.detailDescription = issue.detailDescription
        self.photoSize = issue.coverPhoto?.size
        if let regularPhotoURL = issue.coverPhoto?.urls***REMOVED***CoverPhotoSize.regular***REMOVED*** {
            self.photoURL = regularPhotoURL
        } else {
            self.photoURL = nil
        }
        super.init()
    }
}
