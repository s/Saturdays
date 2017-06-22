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
    var routingService : RoutingService?
    var credentialsHelper : CredentialsHelper?
    var notificationService : NotificationService?
    var imageDownloadingService : ImageDownloadingService?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Window setup
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.initialApplicationSetup(application: application)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        notificationService?.applicationDidBecomeActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        notificationService?.applicationDidEnterBackground(application)
    }
    
    fileprivate func initialApplicationSetup(application:UIApplication) {
        guard let window = self.window else { return }
        self.setup(window: window)
        
        //Setup all services
        self.setupServices()
        guard
            let notificationService = notificationService,
            let routingService = routingService
        else { return }
        
        //Notifications setup
        notificationService.registerForNotifications()
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        //Navigation setup
        window.rootViewController = routingService.createRootViewController()
    }
    
    fileprivate func remoteNotificationApplicationSetup(issueNumber:Int) {
        guard let window = self.window else { return }
        self.setup(window: window)
        
        //Setup all services
        self.setupServices()
        guard let routingService = routingService else { return }
        window.rootViewController = routingService.openIssueForRemoteNotification(number: issueNumber)
    }
    
    fileprivate func setup(window:UIWindow) {
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
    }
    
    fileprivate func setupServices() {
        
        //Creating CredentialsHelper
        do {
            self.credentialsHelper = try CredentialsHelper()
        } catch (let error) {
            print(error.localizedDescription)
            return
        }
        guard let credentialsHelper = credentialsHelper else { return }
        
        self.imageDownloadingService = ImageDownloadingService()
        guard let imageDownloadingService = imageDownloadingService else { return }
        
        self.routingService = RoutingService(imageDownloadingService: imageDownloadingService, credentialsHelper: credentialsHelper)
        self.notificationService = NotificationService(credentialsHelper: credentialsHelper)
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
            
            self.remoteNotificationApplicationSetup(issueNumber: issueNumber)
            
        case .dismiss: break
        }
        completionHandler()
    }
}

