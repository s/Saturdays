//
//  imageDownloadingService.swift
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

class ImageDownloadingService {
    
    //MARK: Properties
    fileprivate lazy var imageDownloader : ImageDownloader = {
        return ImageDownloader(
            configuration: ImageDownloader.defaultURLSessionConfiguration(),
            downloadPrioritization: .lifo,
            maximumActiveDownloads: 4,
            imageCache: AutoPurgingImageCache()
        )
    }()
    fileprivate var receipts : ***REMOVED***URL:RequestReceipt***REMOVED*** = ***REMOVED***:***REMOVED***
    
    //MARK: Public
    func download(cellImage url: URL,
                  downloadProgressHandler: ((Progress) -> Void)?,
                  completionHandler:((ImageDownloadServiceResult, URL) -> Void)?)
    {
        let downloadRequest = URLRequest(url: url)
        let receipt : RequestReceipt? = imageDownloader.download(downloadRequest) { response in
            guard let completionHandler = completionHandler else { return }
            if let error = response.error {
                completionHandler(ImageDownloadServiceResult.failure(error), url)
                return
***REMOVED***
            
            if let image = response.result.value {
                self.receipts***REMOVED***url***REMOVED*** = nil
                completionHandler(ImageDownloadServiceResult.success(image), url)
                return
***REMOVED*** else {
                //TODO: return an error
                return
***REMOVED***
        }
        if let receipt = receipt {
            self.receipts***REMOVED***url***REMOVED*** = receipt
        }
    }
    
    func cancel(downloading url:URL) {
        if let receipt = self.receipts***REMOVED***url***REMOVED*** {
            imageDownloader.cancelRequest(with: receipt)
        }
    }
    
    func prefetch(_ imageUrls:***REMOVED***URL***REMOVED***) {
        for url in imageUrls {
            self.download(cellImage: url, downloadProgressHandler: nil, completionHandler: nil)
        }
    }
    
    func cancelPrefetcing(_ imageUrls:***REMOVED***URL***REMOVED***) {
        for url in imageUrls {
            self.cancel(downloading: url)
        }
    }
}
