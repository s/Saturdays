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
    
    //MARK: Properties
    fileprivate lazy var imageDownloader : ImageDownloader = {
        return ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .fifo,
            maximumActiveDownloads: 4,
            imageCache: AutoPurgingImageCache()
        )
    }()
    fileprivate var requests : ***REMOVED***URL:URLRequest***REMOVED*** = ***REMOVED***:***REMOVED***
    
    //MARK: Public
    func download(cellImage url: URL,
                  downloadProgressHandler: ((Progress) -> Void)?,
                  completionHandler:((ImageDownloadServiceResult, URL) -> Void)?)
    {
        let downloadRequest = URLRequest(url: url)
//        self.requests***REMOVED***url***REMOVED*** = downloadRequest
        
        imageDownloader.download(downloadRequest) { response in
            guard let completionHandler = completionHandler else { return }
            if let error = response.error {
                completionHandler(ImageDownloadServiceResult.failure(error), url)
                return
***REMOVED***
            
            if let image = response.result.value {
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
            
        }
    }
}
