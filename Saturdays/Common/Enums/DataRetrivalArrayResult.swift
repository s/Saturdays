//
//  DataRetrivalResult.swift
//  Saturdays
//
//  Created by Said Ozcan on 22/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

enum DataRetrivalArrayResult<T> {
    case success([T])
    case failure(Error)
}
