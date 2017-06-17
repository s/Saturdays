//
//  AppDelegate.swift
//  Saturdays
//
//  Created by Said Ozcan on 2/11/17.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var notificationService : NotificationService?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        self.setupWindowUI()
        
        self.notificationService = NotificationService()
        notificationService?.registerForNotifications()
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        let imageDownloadingService = ImageDownloadingService()
        let routingService = RoutingService(imageDownloadingService: imageDownloadingService)
        window.rootViewController = routingService.createRootViewController()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        notificationService?.applicationDidBecomeActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        notificationService?.applicationDidEnterBackground(application)
    }
    
    fileprivate func setupWindowUI() {
        guard let window = window else { return }
        
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        
        guard let actionIdentifier = NotificationAction(rawValue: response.actionIdentifier) else {
            completionHandler()
            return
        }
        
        let issueNumberKey = "gcm.notification.issue_number"
        let userInfo = response.notification.request.content.userInfo
        
        switch actionIdentifier {
        case .openIssue, .tap:
            guard
                let issueNumberString = userInfo[issueNumberKey] as? String,
                let issueNumber = Int(issueNumberString)
            else {
                completionHandler()
                return
            }
            
            self.setupWindowUI()
            let imageDownloadingService = ImageDownloadingService()
            let routingService = RoutingService(imageDownloadingService: imageDownloadingService)
            self.window?.rootViewController = routingService.openIssueForRemoteNotification(number: issueNumber)
            
        case .dismiss: break
        }
        completionHandler()
    }
}

