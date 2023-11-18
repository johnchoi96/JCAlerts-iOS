//
//  CloudFirestoreService.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import os

class CloudFirestoreService {

    static let instance = CloudFirestoreService()

    private let db = Firestore.firestore()

    private let logger = os.Logger()

//    private var notifications: [NotificationPayload] = []
//
//    private var notificationDict: [String: NotificationPayload] = [:]

    var delegate: CloudFirestoreDelegate?

    private init() {}

    func fetchNotificationPayloads() {
//        notifications = []
//        notificationDict = [:]
        db.collection("notifications").getDocuments() { (querySnapshot, error) in
            if let error = error {
                self.logger.error("Error getting documents: \(error)")
            } else {
                var notifications: [NotificationPayload] = []
                var notificationDict: [String: NotificationPayload] = [:]
                for document in querySnapshot!.documents {
                    let notificationId = document.documentID
                    let message = document.get("message") as! String
                    let isHtml = document.get("isHtml") as! Bool
                    let timestamp = document.get("timestamp") as! String
                    var topic: FCMTopic
                    let isTestMessage = document.get("test-notification") as? Bool ?? false
                    switch (document.get("topic") as! String) {
                    case FCMTopic.ALL.getTopicValue():
                        topic = .ALL
                    case FCMTopic.PETFINDER.getTopicValue():
                        topic = .PETFINDER
                    case FCMTopic.METALPRICE.getTopicValue():
                        topic = .METALPRICE
                    default:
                        self.logger.error("Invalid topic type")
                        return
                    }

                    let payload = NotificationPayload(notificationId: notificationId, message: message, timestamp: timestamp, topic: topic, isHtml: isHtml, isTestMessage: isTestMessage)
                    notifications.append(payload)
                    notificationDict[notificationId] = payload
                }
                self.delegate?.didFinishLoadingAll(notifications: notifications, notificationsDict: notificationDict)
            }
        }
    }

    func retrieveNotificationPayload(notificationId: String) {
        let docRef = db.collection("notifications").document(notificationId)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let notificationId = document.documentID
                let message = document.get("message") as! String
                let isHtml = document.get("isHtml") as! Bool
                let timestamp = document.get("timestamp") as! String
                var topic: FCMTopic
                let isTestMessage = document.get("test-notification") as? Bool ?? false
                switch (document.get("topic") as! String) {
                case FCMTopic.ALL.getTopicValue():
                    topic = .ALL
                case FCMTopic.PETFINDER.getTopicValue():
                    topic = .PETFINDER
                case FCMTopic.METALPRICE.getTopicValue():
                    topic = .METALPRICE
                default:
                    self.logger.error("Invalid topic type")
                    return
                }
                let payload = NotificationPayload(notificationId: notificationId, message: message, timestamp: timestamp, topic: topic, isHtml: isHtml, isTestMessage: isTestMessage)
                self.delegate?.didFinishLoading(notification: payload)
            } else {
                self.logger.error("Notification with ID \(notificationId) does not exist")
            }
        }
//        if notifications.isEmpty {
//            fetchNotificationPayloads()
//        }
//        guard let payload = self.notificationDict[notificationId] else {
//            logger.error("Notification with ID \(notificationId) does not exist")
//            return nil
//        }
//        return payload
    }

//    func getAllNotifications() -> [NotificationPayload] {
//        return notifications
//    }
}
