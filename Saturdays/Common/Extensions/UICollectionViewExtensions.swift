//
//  UITableViewExtensions.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 17/10/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    
    func register<T: UICollectionViewCell>(nib:T.Type) where T:NSObject{
        let nib = UINib(nibName: T.name, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.name)
    }
}
