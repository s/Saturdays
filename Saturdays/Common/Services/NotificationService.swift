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

class NotificationService : NSObject, UNUserNotificationCenterDelegate, FIRMessagingDelegate {
    
    fileprivate weak var application:UIApplication?
    
    init(with application:UIApplication) {
        self.application = application
        super.init()
    }
    
    func registerForNotifications() {
        guard let application = application else { return }
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = ***REMOVED***.alert, .badge, .sound***REMOVED***
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            FIRMessaging.messaging().remoteMessageDelegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: ***REMOVED***.alert, .badge, .sound***REMOVED***, categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FIRApp.configure()
    }
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
}
