//
//  UIImageExtensions.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/12/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func correctHeight(for screenSize: CGRect) -> CGFloat {
        return (screenSize.width * self.size.height) / self.size.width
    }
}
