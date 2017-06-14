//
//  UIHelper.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Shimmer

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
