//
//  UITableViewExtensions.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/13/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func register<T: UITableViewCell>(nib:T.Type) where T:NSObject{
        let nib = UINib(nibName: T.name, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.name)
    }
    
    func sizeHeaderToFit() {
        guard let headerView = self.tableHeaderView else { return }
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        let oldFrame = headerView.frame
        let newFrame = CGRect(x:oldFrame.origin.x ,
                              y: oldFrame.origin.y,
                              width: oldFrame.size.width,
                              height: height)
        headerView.frame = newFrame
        
        self.tableHeaderView = headerView
    }
}
