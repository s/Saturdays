//
//  Post.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 21/07/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox

enum PostSourceType: String{
    case instagram
    case web
    case unknown
}

struct Post{
    let url: URL?
    let photo: Photo
    let title: String
    let postDescription: String?
    let sourceType: PostSourceType
    let instagramID: String?
}

extension Post: Unboxable{
    init(unboxer: Unboxer) throws{
        
        if let type = try PostSourceType(rawValue: unboxer.unbox(key:"source_type")){
            self.sourceType = type
        }else{
            self.sourceType = PostSourceType.unknown
        }
        
        self.title = try unboxer.unbox(key:"title")
        self.photo = try unboxer.unbox(key: "photo")
        self.url   = try URL(string: unboxer.unbox(key: "url"))
        self.postDescription = unboxer.unbox(key: "post_description")
        self.instagramID = unboxer.unbox(key: "instagram_id")
    }
}

extension Post : ExternallyOpenable {
    var externalURL: URL {
        if self.sourceType == .instagram {
            guard let instagramID = self.instagramID else {
                fatalError("instagram id shouldn't be nil here.")
***REMOVED***
            return URL(string: "instagram://media?id=\(instagramID)")!
        } else {
            guard let url = self.url else {
                fatalError("url shouldn't be nil here.")
***REMOVED***
            return url
        }
    }
}

extension Post : ImageDownloadableModel {
    var imageURL: URL {
        get {
            return self.photo.url
        }
    }
}
