//
//  Venue.swift
//  Saturdays
//
//  Created by Said Ozcan on 11/27/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox

struct Venue {
    let name: String
    let type: String
    let locationInfo: String
    let foursquareID: String
    let photo: Photo
}

extension Venue: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.type = try unboxer.unbox(key: "type")
        self.locationInfo = try unboxer.unbox(key: "location_info")
        self.foursquareID = try unboxer.unbox(key: "foursquare_id")
        self.photo = try unboxer.unbox(key: "photo")
    }
}

extension Venue : ExternallyOpenable {
    var externalURL: URL {
        return URL(string: "foursquare://")!
    }
}

extension Venue : ImageDownloadableModel {
    var imageURL: URL {
        return self.photo.url
    }
}
