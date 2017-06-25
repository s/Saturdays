//
//  FontDefines.swift
//  Saturdays
//
//  Created by Said Ozcan on 25/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

fileprivate struct FontSizes {
    static let small                            : CGFloat = 12.0
    static let medium                           : CGFloat = 14.0
    static let large                            : CGFloat = 16.0
    static let xlarge                           : CGFloat = 18.0
    static let xxxlarge                         : CGFloat = 22.0
    static let navigationBarLargeTitleViewTitle : CGFloat = 34.0
    static let navigationBarContentViewTitle    : CGFloat = 17.0
}

struct FontDefines {
    let title  = UIFont.systemFont(ofSize: FontSizes.large, weight: UIFontWeightRegular)
    let body   = UIFont.systemFont(ofSize: FontSizes.xlarge, weight: UIFontWeightSemibold)
    let detail = UIFont.systemFont(ofSize: FontSizes.large, weight: UIFontWeightRegular)
    let subDetail = UIFont.systemFont(ofSize: FontSizes.large, weight: UIFontWeightLight)
    let subtitle = UIFont.systemFont(ofSize: FontSizes.xxxlarge, weight: UIFontWeightBold)
    let navigationBarLargeTitleViewTitle = UIFont.systemFont(ofSize: FontSizes.navigationBarLargeTitleViewTitle,
                                                             weight:UIFontWeightBold)
    let navigationBarContentViewTitle = UIFont.systemFont(ofSize: FontSizes.navigationBarContentViewTitle,
                                                          weight:UIFontWeightSemibold)
}
