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
    let photoSize: CGSize
    let number : Int
    let tracks : ***REMOVED***TrackViewModel***REMOVED***
    let venues : ***REMOVED***VenueViewModel***REMOVED***
    let posts : ***REMOVED***PostViewModel***REMOVED***
    
    // MARK : Lifecycle
    init(with issue:Issue) {
        self.title = issue.title
        self.detailTitle = issue.detailHeading
        self.detailDescription = issue.detailDescription
        self.photoSize = issue.coverPhoto.size
        self.number = issue.number
        if let regularPhotoURL = issue.coverPhoto.urls***REMOVED***CoverPhotoSize.regular***REMOVED*** {
            self.photoURL = regularPhotoURL
        } else {
            self.photoURL = nil
        }
        self.tracks = issue.tracks.map { (track) -> TrackViewModel in
            return TrackViewModel(with: track)
        }
        self.venues = issue.venues.map { (venue) -> VenueViewModel in
            return VenueViewModel(with: venue)
        }
        self.posts = issue.posts.map { (post) -> PostViewModel in
            return PostViewModel(with: post)
        }
        super.init()
    }
}
