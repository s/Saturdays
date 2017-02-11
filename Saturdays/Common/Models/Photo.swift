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

struct Photo{
    let url: URL?
    let size: CGSize?
}

extension Photo: Unboxable{
    init(unboxer: Unboxer) throws{
        self.url = try URL(string: unboxer.unbox(key: "url"))
        
        let width: Double? = unboxer.unbox(key: "width")
        let height: Double? = unboxer.unbox(key: "height")
        
        if let width = width, let height = height {
            self.size = CGSize(width: width, height: height)
        } else {
            self.size = nil
        }
    }
}
