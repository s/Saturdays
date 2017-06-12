//
//  UIHelper.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Shimmer

struct UIDefines {
    static let issueDetailsTransitionDuration : TimeInterval = 2
    
    fileprivate struct FontSizes {
        static let small : CGFloat = 12.0
        static let medium: CGFloat = 14.0
        static let large : CGFloat = 16.0
        static let xlarge: CGFloat = 18.0
        static let navigationBarLargeTitleViewTitle : CGFloat = 34.0
        static let navigationBarContentViewTitle : CGFloat = 17.0
    }
    
    struct Spacings {
        static let singleUnit : CGFloat = 8.0
        static let doubleUnit : CGFloat = 16.0
        static let cellSpacing: CGFloat = 24.0
    }
    
    struct Fonts {
        static let title  = UIFont.systemFont(ofSize: UIDefines.FontSizes.large, weight: UIFontWeightRegular)
        static let body   = UIFont.systemFont(ofSize: UIDefines.FontSizes.xlarge, weight: UIFontWeightRegular)
        static let detail = UIFont.systemFont(ofSize: UIDefines.FontSizes.small, weight: UIFontWeightLight)
        static let navigationBarLargeTitleViewTitle = UIFont.systemFont(ofSize: UIDefines.FontSizes.navigationBarLargeTitleViewTitle,
                                                                   weight:UIFontWeightBold)
        static let navigationBarContentViewTitle = UIFont.systemFont(ofSize: UIDefines.FontSizes.navigationBarContentViewTitle,
                                                                weight:UIFontWeightSemibold)
    }
    
    struct Colors {
        static let lightGray = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        static let white     = UIColor.white
        static let black     = UIColor.black
        static let navigationBarTintColor = UIDefines.Colors.white
    }
    
    struct Copies {
        static let saturdaysTitle = NSLocalizedString("SATURDAYS", comment: "")
    }
    
    struct Sizes {
        static let defaultIssueCellHeight : CGFloat = 250.0
        static let navigationBarViewHeight : CGFloat = 96.0
        static let navigationBarLargeTitleViewHeight : CGFloat = 52.0
        static let navigationBarContentViewHeight : CGFloat = 44.0
        static let issueListCellCornerRadius : CGFloat = 8.0
    }
}

class UIHelper: NSObject {
    static func createShimmerBlocks(numberOf count:Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = UIDefines.Spacings.singleUnit
        
        for _ in 0..<count {
            let block = self.createAShimmerBlock()
            block.isShimmering = true
            stackView.addArrangedSubview(block)
        }
        
        return stackView
    }
    
    static func createAShimmerBlock() -> FBShimmeringView {
        
        let shimmeringView = FBShimmeringView(frame: CGRect.zero)
        shimmeringView.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIDefines.Colors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        shimmeringView.contentView = view
        return shimmeringView
    }
}
