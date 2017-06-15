//
//  CoverPhoto.swift
//  Saturdays
//
//  Created by Said Ozcan on 08/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
//
//  Photo.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 21/07/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import CoreGraphics.CGGeometry
import Unbox

enum CoverPhotoSize : String {
    case raw
    case full
    case regular
    case small
    case thumb
    case custom
}

struct CoverPhoto{
    let urls:***REMOVED***CoverPhotoSize:URL***REMOVED***
    let size: CGSize
}

extension CoverPhoto: Unboxable{
    init(unboxer: Unboxer) throws{
        let width: Double = try unboxer.unbox(key: "width")
        let height: Double = try unboxer.unbox(key: "height")
        self.size = CGSize(width: width, height: height)
        
        var allUrls : ***REMOVED***CoverPhotoSize:URL***REMOVED*** = ***REMOVED***:***REMOVED***
        if let urls : ***REMOVED***String:String***REMOVED*** = try? unboxer.unbox(keyPath: "urls") {
            for (key, urlString) in urls {
                if let size = CoverPhotoSize(rawValue: key),
                    let url = URL(string:urlString)
                {
                    allUrls***REMOVED***size***REMOVED*** = url
***REMOVED***
***REMOVED***
        }
        self.urls = allUrls
    }
}
