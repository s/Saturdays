//
//  IssueService.swift
//  Saturdays
//
//  Created by Muhammed Said Özcan on 16/08/16.
//  Copyright © 2016 Muhammed Said Özcan. All rights reserved.
//

import Foundation
import Unbox
import Alamofire
import UnboxedAlamofire

internal enum Result<T> {
    case success([T])
    case failure(Error)
}

internal enum JSONDataRetrivalError: Error{
    case noConfigFileFound
    case noJSONDataFound
    case mappingError(message: String)
    case jsonDataReadingError(message: String)
    
    var description: String{
        switch self{
        case .noConfigFileFound:
            return "No config file found named: APICredentials.plist"
        case .noJSONDataFound:
            return "No demo json data found named: demo.json"
        case .jsonDataReadingError(let message):
            return message
        case .mappingError(let message):
            return message
        }
    }
}


class IssueService: NSObject{
    
    func get(_ completionHandler: @escaping (Result<Issue>) -> Void){
        self.fetchJSON { (result) in
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
            
            guard let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary else{
                let readingError = JSONDataRetrivalError.jsonDataReadingError(message: "Can't serialize json data.")
                completion(Result.failure(readingError))
                return
            }
            
            guard let allItems = jsonDictionary["issues"] as? [UnboxableDictionary] else {
                let mappingError = JSONDataRetrivalError.mappingError(message: "Can't map")
                completion(Result.failure(mappingError))
                return
            }
            
            let unboxedIssueItems: [Issue] = try unbox(dictionaries: allItems)
            completion(Result.success(unboxedIssueItems))
            
            print(unboxedIssueItems)
            
        }catch let error{
            print(error)
            let readingError = JSONDataRetrivalError.jsonDataReadingError(message: error.localizedDescription)
            completion(Result.failure(readingError))
        }
    }

    fileprivate func fetchJSON(with completion:@escaping (Result<Issue>)->Void) {
        
        guard let path = Bundle.main.path(forResource: "APICredentials", ofType: "plist") else {
            let error = JSONDataRetrivalError.noConfigFileFound
            completion(Result.failure(error))
            return
        }
        
        guard let credentials = NSDictionary(contentsOfFile: path) else {
            let readingError = JSONDataRetrivalError.jsonDataReadingError(message: "Can't read APICredentials.plist data as NSDictionary.")
            completion(Result.failure(readingError))
            return
        }
        
        guard let apiURL = credentials["api_url"] as? String, let token = credentials["authentication_token"] as? String else {
            let readingError = JSONDataRetrivalError.jsonDataReadingError(message: "Can't find credentials in the APICredentials.plist file.")
            completion(Result.failure(readingError))
            return
        }
        
        let authorizationHeaders = ["Authorization": "Token \(token)",
                                    "Content-Type": "application/json",
                                    "Accept": "application/json"]
        
        Alamofire.request(apiURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: authorizationHeaders).responseArray(keyPath: "issues") { (response: DataResponse<[Issue]>) in
            switch (response.result) {
            case .success(let issues):
                completion(Result.success(issues))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
