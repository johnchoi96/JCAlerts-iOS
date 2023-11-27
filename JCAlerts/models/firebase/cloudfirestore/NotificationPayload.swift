//
//  NotificationPayload.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import Foundation

struct NotificationPayload {
    var notificationTitle: String

    var notificationSubtitle: String
    
    var notificationId: String

    var message: String

    var timestamp: Date

    var topic: FCMTopic
    
    var isHtml: Bool

    var isTestMessage: Bool
}
