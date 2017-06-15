//
//  UIDefines.swift
//  Saturdays
//
//  Created by Said Ozcan on 15/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

struct UIDefines {
    static let issueDetailsTransitionDuration : TimeInterval = 3
    
    fileprivate struct FontSizes {
        static let small                            : CGFloat = 12.0
        static let medium                           : CGFloat = 14.0
        static let large                            : CGFloat = 16.0
        static let xlarge                           : CGFloat = 18.0
        static let xxxlarge                         : CGFloat = 22.0
        static let navigationBarLargeTitleViewTitle : CGFloat = 34.0
        static let navigationBarContentViewTitle    : CGFloat = 17.0
    }
    
    struct Spacings {
        static let singleUnit : CGFloat = 8.0
        static let doubleUnit : CGFloat = 16.0
        static let cellSpacing: CGFloat = 24.0
    }
    
    struct Fonts {
        static let title  = UIFont.systemFont(ofSize: UIDefines.FontSizes.large, weight: UIFontWeightRegular)
        static let body   = UIFont.systemFont(ofSize: UIDefines.FontSizes.xlarge, weight: UIFontWeightSemibold)
        static let detail = UIFont.systemFont(ofSize: UIDefines.FontSizes.large, weight: UIFontWeightRegular)
        static let subDetail = UIFont.systemFont(ofSize: UIDefines.FontSizes.large, weight: UIFontWeightLight)
        static let subtitle = UIFont.systemFont(ofSize: UIDefines.FontSizes.xxxlarge, weight: UIFontWeightBold)
        static let navigationBarLargeTitleViewTitle = UIFont.systemFont(ofSize: UIDefines.FontSizes.navigationBarLargeTitleViewTitle,
                                                                        weight:UIFontWeightBold)
        static let navigationBarContentViewTitle = UIFont.systemFont(ofSize: UIDefines.FontSizes.navigationBarContentViewTitle,
                                                                     weight:UIFontWeightSemibold)
    }
    
    struct Colors {
        static let lightGray              = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let white                  = UIColor.white
        static let black                  = UIColor.black
        static let navigationBarTintColor = UIDefines.Colors.white
    }
    
    struct Copies {
        static let saturdaysTitle = NSLocalizedString("SATURDAYS", comment: "")
        static let tracksTitle = NSLocalizedString("Tracks", comment: "")
        static let venuesTitle = NSLocalizedString("Venues", comment: "")
        static let postsTitle  = NSLocalizedString("Posts", comment: "")
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
