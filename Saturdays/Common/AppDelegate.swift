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
                     didFinishLaunchingWithOptions launchOptions: ***REMOVED***UIApplicationLaunchOptionsKey: Any***REMOVED***?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return false }
        
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        
        self.notificationService = NotificationService(with: application)
        notificationService?.registerForNotifications()
        
        let imageDownloadService = ImageDownloadService()
        let routingService = RoutingService(imageDownloadService: imageDownloadService)
        window.rootViewController = routingService.createRootViewController()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        notificationService?.applicationDidBecomeActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        notificationService?.applicationDidEnterBackground(application)
    }
}
