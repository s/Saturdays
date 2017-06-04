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
    enum Spacings : CGFloat, RawRepresentable {
        case singleUnit = 8.0
        case doubleUnit = 16.0
    }
    
    fileprivate struct FontSizes {
        static let small : CGFloat = 12.0
        static let medium: CGFloat = 14.0
        static let large : CGFloat = 16.0
    }
    
    struct Fonts {
        static let titleFont  = UIFont.systemFont(ofSize: UIDefines.FontSizes.large, weight: UIFontWeightRegular)
        static let bodyFont   = UIFont.systemFont(ofSize: UIDefines.FontSizes.medium, weight: UIFontWeightLight)
        static let detailFont = UIFont.systemFont(ofSize: UIDefines.FontSizes.small, weight: UIFontWeightLight)
    }
    
    struct Colors {
        static let lightGrayColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1)
        static let whiteColor     = UIColor.white
    }
}

class UIHelper: NSObject {
    static func createShimmerBlocks(numberOf count:Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = UIDefines.Spacings.singleUnit.rawValue
        
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
        view.backgroundColor = UIDefines.Colors.lightGrayColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        shimmeringView.contentView = view
        return shimmeringView
    }
}
