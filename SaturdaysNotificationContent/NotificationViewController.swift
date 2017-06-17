//
//  NotificationViewController.swift
//  SaturdaysNotificationContent
//
//  Created by Said Ozcan on 17/06/2017.
//  Copyright © 2017 Said Ozcan. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var issueImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        let content = notification.request.content
        guard let attachment = content.attachments.first else { return }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            issueImageView.image = UIImage(contentsOfFile: attachment.url.path)
            attachment.url.stopAccessingSecurityScopedResource()
        }
    }
}
