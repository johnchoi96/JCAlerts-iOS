//
//  CloudFirestoreDelegate.swift
//  JCAlerts
//
//  Created by John Choi on 11/18/23.
//

import Foundation

protocol CloudFirestoreDelegate {

    /**
     Called when all notifications have been fetched from the DB.
     - Parameter notifications: list of notification payloads
     - Parameter notificationsDict: dictionary of notification IDs mapped to notification payloads
     */
    func didFinishLoadingAll(notifications: [NotificationPayload], notificationsDict: [String: NotificationPayload])

    func didFinishLoadingSingleNotification(notificationId: String, notification: NotificationPayload)

    func didFinishUploadingComment()
}

extension CloudFirestoreDelegate {

    func didFinishLoadingAll(notifications: [NotificationPayload], notificationsDict: [String: NotificationPayload]) {}

    func didFinishLoadingSingleNotification(notificationId: String, notification: NotificationPayload) {}

    func didFinishUploadingComment() {}
}
