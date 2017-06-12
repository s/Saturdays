//
//  CGRectExtensions.swift
//  Saturdays
//
//  Created by Said Ozcan on 12/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

extension CGSize {
    func appropriateSize(for screenSize:CGSize) -> CGSize {
        let height = ( screenSize.width * self.height ) / self.width
        let size = CGSize(width: screenSize.width, height: height)
        return size
    }
}
