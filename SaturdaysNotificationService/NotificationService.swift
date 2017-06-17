//
//  NotificationService.swift
//  SaturdaysNotificationService
//
//  Created by Said Ozcan on 17/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import MobileCoreServices
import UserNotifications

class NotificationService: UNNotificationServiceExtension {
    
    fileprivate let attachmentUrlKey = "gcm.notification.attachment_url"
    fileprivate let attachmentIdentifier = "co.saidozcan.saturdaysnotificationservice.notificationimage"
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

        self.contentHandler = contentHandler
        
        guard let bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent) else {
            return
        }
        
        guard let attachmentUrlString = request.content.userInfo[attachmentUrlKey] as? String else {
            contentHandler(bestAttemptContent)
            return
        }
        
        guard let requestUrl = URL(string: attachmentUrlString) else {
            contentHandler(bestAttemptContent)
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.downloadTask(with: requestUrl) { [weak self] (temporaryFileLocationUrl, _, _) in
            session.finishTasksAndInvalidate()
            
            guard let location = temporaryFileLocationUrl,
                let attachmentIdentifier = self?.attachmentIdentifier else {
                contentHandler(bestAttemptContent)
                return
            }
            
            let temporaryDirectory = NSTemporaryDirectory()
            let fileUrlStringOnDisk = "file://\(temporaryDirectory)\(requestUrl.lastPathComponent).jpg"
            
            guard let fileURL = URL(string: fileUrlStringOnDisk) else {
                contentHandler(bestAttemptContent)
                return
            }
            
            do {
                if FileManager.default.fileExists(atPath: fileURL.relativePath) {
                    try FileManager.default.removeItem(at: fileURL)
                }
                try FileManager.default.moveItem(at: location, to: fileURL)
                
                let attachment = try UNNotificationAttachment(identifier: attachmentIdentifier, url: fileURL)
                bestAttemptContent.attachments = [attachment]
                
            } catch let error {
                print("Error: \(error)")
            }
            
            contentHandler(bestAttemptContent)
        }
        task.resume()
    }
//
//    override func serviceExtensionTimeWillExpire() {
//        // Called just before the extension will be terminated by the system.
//        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            contentHandler(bestAttemptContent)
//        }
//    }
}

