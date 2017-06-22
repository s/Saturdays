//
//  DataHelper.swift
//  Saturdays
//
//  Created by Said Ozcan on 22/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation

class CredentialsHelper {
    
    //MARK: Properties
    let apiURL : String
    let token : String
    let authorizationHeaders : [String:String]
    
    //MARK: Lifecycle
    init() throws {
        guard let path = Bundle.main.path(forResource: "APICredentials", ofType: "plist") else {
            throw DataRetrivalError.noSuchFileFound(fileName: "APICredentials.plist")
        }
        
        guard let credentials = NSDictionary(contentsOfFile: path) else {
            throw DataRetrivalError.jsonDataReadingError(message: "Can't read APICredentials.plist data as NSDictionary.")
        }
        
        guard let apiURL = credentials["api_url"] as? String, let token = credentials["authentication_token"] as? String else {
            throw DataRetrivalError.jsonDataReadingError(message: "Can't find credentials in the APICredentials.plist file.")
        }
        
        self.apiURL = apiURL
        self.token = token
        self.authorizationHeaders = [
            "Authorization": "Token \(token)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
