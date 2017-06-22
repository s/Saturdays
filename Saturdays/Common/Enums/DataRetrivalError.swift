//
//  DataRetrivalError.swift
//  Saturdays
//
//  Created by Said Ozcan on 22/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

enum DataRetrivalError: Error{
    case noSuchFileFound(fileName:String)
    case mappingError(message: String)
    case jsonDataReadingError(message: String)
    
    var description: String{
        switch self{
        case .noSuchFileFound(let fileName):
            return "No file found named: \(fileName)"
        case .jsonDataReadingError(let message):
            return message
        case .mappingError(let message):
            return message
        }
    }
}
