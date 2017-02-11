//
//  NSObjectExtensions.swift
//  Saturdays
//
//  Created by Said Ozcan on 12/19/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation

public extension NSObject{
    public class var name: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var name: String{
        return NSStringFromClass(type(of:self)).components(separatedBy: ".").last!
    }
}
