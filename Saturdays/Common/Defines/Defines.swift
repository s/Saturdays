//
//  Defines.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

struct Defines {
    static let issueDetailsTransitionDuration : TimeInterval = 3
    
    static let colors   = ColorDefines()
    static let copies   = CopyDefines()
    static let spacings = SpacingDefines()
    
    fileprivate struct FontSizes {
        static let small                            : CGFloat = 12.0
        static let medium                           : CGFloat = 14.0
        static let large                            : CGFloat = 16.0
        static let xlarge                           : CGFloat = 18.0
        static let xxxlarge                         : CGFloat = 22.0
        static let navigationBarLargeTitleViewTitle : CGFloat = 34.0
        static let navigationBarContentViewTitle    : CGFloat = 17.0
    }
    
    struct Fonts {
        static let title  = UIFont.systemFont(ofSize: Defines.FontSizes.large, weight: UIFontWeightRegular)
        static let body   = UIFont.systemFont(ofSize: Defines.FontSizes.xlarge, weight: UIFontWeightSemibold)
        static let detail = UIFont.systemFont(ofSize: Defines.FontSizes.large, weight: UIFontWeightRegular)
        static let subDetail = UIFont.systemFont(ofSize: Defines.FontSizes.large, weight: UIFontWeightLight)
        static let subtitle = UIFont.systemFont(ofSize: Defines.FontSizes.xxxlarge, weight: UIFontWeightBold)
        static let navigationBarLargeTitleViewTitle = UIFont.systemFont(ofSize: Defines.FontSizes.navigationBarLargeTitleViewTitle,
                                                                        weight:UIFontWeightBold)
        static let navigationBarContentViewTitle = UIFont.systemFont(ofSize: Defines.FontSizes.navigationBarContentViewTitle,
                                                                     weight:UIFontWeightSemibold)
    }
    
    struct Sizes {
        static let defaultIssueCellHeight            : CGFloat = 250.0
        static let navigationBarViewHeight           : CGFloat = 96.0
        static let navigationBarLargeTitleViewHeight : CGFloat = 52.0
        static let navigationBarContentViewHeight    : CGFloat = 44.0
        static let issueListCellCornerRadius         : CGFloat = 8.0
        static let issueDetailsDismissIconDimension  : CGFloat = 40.0
        static let issueDetailsTrackAlbumArtDimension: CGFloat = 80
        static let issueDetailsTracksHeight          : CGFloat = 200.0
        static let issueDetailsTableViewInset        : CGFloat = -20.0
    }
}
