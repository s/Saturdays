//
//  ImageDownloadService.swift
//  Saturdays
//
//  Created by Said Ozcan on 04/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

enum ImageDownloadServiceResult {
    case success(UIImage)
    case failure(Error)
}

class ImageDownloadService {
    
    fileprivate var requests : ***REMOVED***URL:DownloadRequest***REMOVED*** = ***REMOVED***:***REMOVED***
    
    func download(cellImage url: URL,
                  downloadProgressHandler: ((Progress) -> Void)?,
                  completionHandler:((ImageDownloadServiceResult, URL) -> Void)?)
    {
        let downloadRequest = Alamofire.download(url)
        self.requests***REMOVED***url***REMOVED*** = downloadRequest
        
        downloadRequest.downloadProgress { (progress) in
                downloadProgressHandler?(progress)
        }.responseData(queue: DispatchQueue.main) { (response) in
            guard let completionHandler = completionHandler else { return }
            if let error = response.error {
                completionHandler(ImageDownloadServiceResult.failure(error), url)
                return
***REMOVED***
            
            if let imageData = response.result.value,
                let image = UIImage(data:imageData) {
                self.requests***REMOVED***url***REMOVED*** = nil
                completionHandler(ImageDownloadServiceResult.success(image), url)
                return
***REMOVED*** else {
                //TODO: return an error
                return
***REMOVED***
        }
    }
    
    func cancel(downloading url:URL) {
        if let request = self.requests***REMOVED***url***REMOVED*** {
            request.cancel()
        }
    }
}
