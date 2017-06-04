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
    
    fileprivate weak var application:UIApplication?
    fileprivate let gcmMessageIDKey = "gcm.message_id"
    
    init(with application:UIApplication) {
        self.application = application
        super.init()
    }
    
    func registerForNotifications() {
        guard let application = application else { return }
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = ***REMOVED***.alert, .badge, .sound***REMOVED***
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.tokenRefreshNotification),
                                               name: .firInstanceIDTokenRefresh,
                                               object: nil)
        
        FIRApp.configure()
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

extension NotificationService : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo***REMOVED***gcmMessageIDKey***REMOVED*** {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
