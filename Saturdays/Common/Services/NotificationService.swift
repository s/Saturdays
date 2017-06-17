//
//  NotificationService.swift
//  Saturdays
//
//  Created by Said Ozcan on 02/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import Foundation
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging

protocol NotificationServiceProtocol {
    func applicationDidBecomeActive(_ application: UIApplication)
    func applicationDidEnterBackground(_ application: UIApplication)
}

class NotificationService : NSObject {
    
    
    fileprivate let newIssueIdentifier = "new_issue"
    
    func registerForNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        let authOptions: UNAuthorizationOptions = ***REMOVED***.alert, .badge, .sound***REMOVED***
        
        let openIssueAction = UNNotificationAction(identifier: NotificationAction.openIssue.rawValue, title: UIDefines.Copies.openIssue, options: ***REMOVED***UNNotificationActionOptions.foreground***REMOVED***)
        let dismissAction   = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: UIDefines.Copies.dismiss, options: ***REMOVED******REMOVED***)
        let generalCategory = UNNotificationCategory(identifier: newIssueIdentifier,
                                                     actions: ***REMOVED***openIssueAction, dismissAction***REMOVED***,
                                                     intentIdentifiers: ***REMOVED******REMOVED***,
                                                     options: .customDismissAction)
        
        notificationCenter.setNotificationCategories(***REMOVED***generalCategory***REMOVED***)
        notificationCenter.requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
        FIRApp.configure()
        FIRMessaging.messaging().remoteMessageDelegate = self
    }
    
    @objc fileprivate func tokenRefreshNotification(_ notification: Notification) {
        if let refreshedToken = FIRInstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        
        // Connect to FCM since connection may have failed when attempted before having a token.
        connectToFcm()
    }
    
    fileprivate func connectToFcm() {
        // Won't connect since there is no token
        guard FIRInstanceID.instanceID().token() != nil else {
            return
        }
        
        // Disconnect previous FCM connection if it exists.
        FIRMessaging.messaging().disconnect()
        
        FIRMessaging.messaging().connect { (error) in
            if error != nil {
                print("Unable to connect with FCM. \(String(describing: error?.localizedDescription))")
***REMOVED*** else {
                print("Connected to FCM.")
***REMOVED***
        }
    }
}

extension NotificationService : NotificationServiceProtocol {
    func applicationDidBecomeActive(_ application: UIApplication) {
        connectToFcm()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
}


