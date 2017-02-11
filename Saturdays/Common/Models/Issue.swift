//
//  Issue.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 21/07/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox

struct Issue{
    let number: Int
    let title: String
    let detailHeading: String
    let detailDescription: String
    let creationDate: Date?
    let coverPhoto: Photo?

    let tracks: ***REMOVED***Track***REMOVED***
    let venues: ***REMOVED***Venue***REMOVED***
    let posts: ***REMOVED***Post***REMOVED***
}

extension Issue: Unboxable{
    internal init(unboxer: Unboxer) throws{
        self.number = try unboxer.unbox(key: "number")
        self.title = try unboxer.unbox(key: "title")
        self.detailHeading = try unboxer.unbox(key: "detail_heading")
        self.detailDescription = try unboxer.unbox(key: "detail_description")
        
        self.creationDate = unboxer.unbox(key: "created_at", formatter: Date.iso8601Formatter)
        self.coverPhoto = unboxer.unbox(key: "cover_photo")
        
        self.tracks = try unboxer.unbox(key: "tracks")
        self.venues = try unboxer.unbox(key: "venues")
        self.posts = try unboxer.unbox(key: "posts")
    }
}

