//
//  Post.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 21/07/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation

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
