//
//  VenueViewModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 13/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class VenueViewModel : NSObject, ViewModelProtocol {
    
    // MARK : Properties
    let venueName : String
    let type : String
    let locationInfo : String
    let photoUrl : URL
    let photoSize : CGSize?
    let deeplinkURL : URL
    
    // MARK : Lifecycle
    init(with venue:Venue) {
        self.venueName = venue.name
        self.type = venue.type
        self.locationInfo = venue.locationInfo
        self.photoUrl = venue.photo.url
        self.photoSize = venue.photo.size
        self.deeplinkURL = venue.externalURL
        super.init()
    }
}

