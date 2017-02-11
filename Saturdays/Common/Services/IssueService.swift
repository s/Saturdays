//
//  IssueService.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 16/08/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox

internal enum Result<T> {
    case success(***REMOVED***T***REMOVED***)
    case failure(Error)
}

internal enum JSONDataRetrivalError: Error{
    case noJSONDataFound
    case mappingError(message: String)
    case jsonDataReadingError(message: String)
    
    var description: String{
        switch self{
        case .noJSONDataFound:
            return "No wheel json data found named: demo.json"
        case .jsonDataReadingError(let message):
            return message
        case .mappingError(let message):
            return message
        }
    }
}


class IssueService: NSObject{
    
    func get(_ completionHandler: @escaping (Result<Issue>) -> Void){
        self.readJSON { (result) in
            completionHandler(result)
        }
    }
    
    fileprivate func readJSON(with completion:(Result<Issue>)->Void){
        guard let path = Bundle.main.path(forResource: "demo", ofType: "json") else {
            let error = JSONDataRetrivalError.noJSONDataFound
            completion(Result.failure(error))
            return
        }
        
        do{
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            guard let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSArray else{
                let readingError = JSONDataRetrivalError.jsonDataReadingError(message: "Can't serialize json data.")
                completion(Result.failure(readingError))
                return
***REMOVED***
            
            guard let allItems = jsonArray as? ***REMOVED***UnboxableDictionary***REMOVED*** else {
                let mappingError = JSONDataRetrivalError.mappingError(message: "Can't map")
                completion(Result.failure(mappingError))
                return
***REMOVED***
            
            let unboxedIssueItems: ***REMOVED***Issue***REMOVED*** = try unbox(dictionaries: allItems)
            completion(Result.success(unboxedIssueItems))
            
            print(unboxedIssueItems)
            
        }catch let error{
            print(error)
            let readingError = JSONDataRetrivalError.jsonDataReadingError(message: error.localizedDescription)
            completion(Result.failure(readingError))
        }
    }

}
