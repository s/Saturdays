//
//  PlatformHelper.swift
//  Saturdays
//
//  Created by Said Ozcan on 22/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
