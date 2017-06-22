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
import Alamofire

protocol NotificationServiceProtocol {
    func applicationDidBecomeActive(_ application: UIApplication)
    func applicationDidEnterBackground(_ application: UIApplication)
}

class NotificationService : NSObject {
    
    //MARK: Properties
    fileprivate let newIssueIdentifier = "new_issue"
    private let credentialsHelper : CredentialsHelper
    
    //MARK: Lifecycle
    init(credentialsHelper:CredentialsHelper) {
        self.credentialsHelper = credentialsHelper
    }
    
    //MARK: Interface
    func registerForNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        let openIssueAction = UNNotificationAction(identifier: NotificationAction.openIssue.rawValue, title: UIDefines.Copies.openIssue, options: [UNNotificationActionOptions.foreground])
        let dismissAction   = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue, title: UIDefines.Copies.dismiss, options: [])
        let generalCategory = UNNotificationCategory(identifier: newIssueIdentifier,
                                                     actions: [openIssueAction, dismissAction],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        
        notificationCenter.setNotificationCategories([generalCategory])
        notificationCenter.requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        
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
            } else {
                print("Connected to FCM.")
            }
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


