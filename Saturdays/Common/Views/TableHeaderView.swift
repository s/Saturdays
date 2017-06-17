//
//  TableHeaderView.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/3/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit

class TableHeaderView: UIView {
    
    private let type: IssueItemType
    
    init?(with type:IssueItemType){
        self.type = type
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setup() {
        self.backgroundColor = UIColor.white
        
        let iconView = UIImageView(image: UIImage(named: self.type.rawValue))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: iconView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: 20),
            NSLayoutConstraint(item: iconView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: 20),
            NSLayoutConstraint(item: iconView,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: iconView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0)
            ])
    }
}
