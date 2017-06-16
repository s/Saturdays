//
//  PostViewModel.swift
//  Saturdays
//
//  Created by Said Ozcan on 13/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class PostViewModel : NSObject, ViewModelProtocol {
    
    // MARK : Properties
    let title : String
    let url : URL?
    let photoUrl : URL
    let photoSize: CGSize?
    let deeplinkURL : URL
    
    // MARK : Lifecycle
    init(with post:Post) {
        self.title = post.title
        self.url = post.url
        self.photoUrl = post.photo.url
        self.photoSize = post.photo.size
        self.deeplinkURL = post.externalURL
        super.init()
    }
}


