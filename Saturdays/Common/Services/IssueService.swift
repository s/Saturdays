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

class IssueService: NSObject{
    
    //MARK: Properties
    private let credentialsHelper : CredentialsHelper
    
    //MARK: Lifecycle
    init(credentialsHelper:CredentialsHelper) {
        self.credentialsHelper = credentialsHelper
    }
    
    //MARK: Public Interface
    func get(_ completionHandler: @escaping (DataRetrivalArrayResult<Issue>) -> Void){
        self.fetchJSON { (result) in
            completionHandler(result)
        }
    }
    
    
    //MARK: Private Methods
    fileprivate func readJSON(with completion:(DataRetrivalArrayResult<Issue>)->Void){
        guard let path = Bundle.main.path(forResource: "demo", ofType: "json") else {
            let error = DataRetrivalError.noSuchFileFound(fileName: "demo.json")
            completion(DataRetrivalArrayResult.failure(error))
            return
        }
        
        do{
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            guard let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? NSDictionary else{
                let readingError = DataRetrivalError.jsonDataReadingError(message: "Can't serialize json data.")
                completion(DataRetrivalArrayResult.failure(readingError))
                return
            }
            
            guard let allItems = jsonDictionary["issues"] as? [UnboxableDictionary] else {
                let mappingError = DataRetrivalError.mappingError(message: "Can't map the json data.")
                completion(DataRetrivalArrayResult.failure(mappingError))
                return
            }
            
            let unboxedIssueItems: [Issue] = try unbox(dictionaries: allItems)
            completion(DataRetrivalArrayResult.success(unboxedIssueItems))
            
            print(unboxedIssueItems)
            
        } catch let error {
            print(error)
            let readingError = DataRetrivalError.jsonDataReadingError(message: error.localizedDescription)
            completion(DataRetrivalArrayResult.failure(readingError))
        }
    }

    fileprivate func fetchJSON(with completion:@escaping (DataRetrivalArrayResult<Issue>)->Void) {
        Alamofire
            .request(credentialsHelper.apiURL.appending(ServiceEndpoint.issues.rawValue),
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: credentialsHelper.authorizationHeaders)
            .responseArray(keyPath: "issues") { (response: DataResponse<[Issue]>) in
                switch (response.result) {
                case .success(let issues):
                    completion(DataRetrivalArrayResult.success(issues))
                case .failure(let error):
                    completion(DataRetrivalArrayResult.failure(error))
                }
            }
    }
}
