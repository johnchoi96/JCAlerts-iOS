//
//  CloudFirestoreDelegate.swift
//  JCAlerts
//
//  Created by John Choi on 11/18/23.
//

import Foundation

protocol CloudFirestoreDelegate {

    func didFinishLoadingAll(notifications: [NotificationPayload], notificationsDict: [String: NotificationPayload])

    func didFinishLoading(notification: NotificationPayload)
}
