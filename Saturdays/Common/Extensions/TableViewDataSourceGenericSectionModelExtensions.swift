//
//  TableViewDataSourceGenericSectionModelExtensions.swift
//  Saturdays
//
//  Created by Said Ozcan on 3/4/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension TableViewDataSourceGenericSectionProtocol {
    func download(cellImage url: URL,
                  downloadProgressHandler: @escaping (Progress) -> Void,
                  completionHandler:@escaping (DataResponse<Image>) -> Void)
    {
        Alamofire.request(url).downloadProgress(closure: { (progress) in
            downloadProgressHandler(progress)
        }).responseImage { (response) in
            completionHandler(response)
        }
    }
}
