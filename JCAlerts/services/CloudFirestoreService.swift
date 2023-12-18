//
//  CloudFirestoreService.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import os

class CloudFirestoreService: ObservableObject {

    private let db = Firestore.firestore()

    private let logger = os.Logger()

    private let userService = UserService.instance

    var delegate: CloudFirestoreDelegate?

    private let DB_COLLECTION_NOTIFICATIONS = "notifications"

    private let DB_COLLECTION_NOTIFICATION_COMMENTS = "notification-comments"

    func fetchNotificationPayloads() {
        db.collection(DB_COLLECTION_NOTIFICATIONS).order(by: "timestamp", descending: true).getDocuments() { (querySnapshot, error) in
            if let error = error {
                self.logger.error("Error getting documents: \(error)")
            } else {
                var notifications: [NotificationPayload] = []
                var notificationDict: [String: NotificationPayload] = [:]
                for document in querySnapshot!.documents {
                    let isTestMessage = document.get("test-notification") as? Bool ?? false
#if !DEBUG
                    // if on prod, ignore test messages
                    if isTestMessage {
                        continue
                    }
#endif

                    let notificationId = document.documentID
                    let message = document.get("message") as! String
                    let isHtml = document.get("isHtml") as! Bool
                    let timestamp = document.get("timestamp") as! String
                    var topic: FCMTopic
                    let notificationTitle = document.get("notification-title") as! String
                    let notificationSubtitle = document.get("notification-body") as! String
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

                    let payload = NotificationPayload(id: UUID(), notificationTitle: notificationTitle, notificationSubtitle: notificationSubtitle, notificationId: notificationId, message: message, timestamp: timestamp.utcTimestampToDate(), topic: topic, isHtml: isHtml, isTestMessage: isTestMessage)
                    notifications.append(payload)
                    notificationDict[notificationId] = payload
                }
                self.delegate?.didFinishLoadingAll(notifications: notifications, notificationsDict: notificationDict)
            }
        }
    }

    func retrieveNotificationPayload(notificationId: String) {
        let docRef = db.collection(DB_COLLECTION_NOTIFICATIONS).document(notificationId)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let notificationId = document.documentID
                let message = document.get("message") as! String
                let isHtml = document.get("isHtml") as! Bool
                let timestamp = document.get("timestamp") as! String
                let notificationTitle = document.get("notification-title") as! String
                let notificationSubtitle = document.get("notification-body") as! String
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
                let payload = NotificationPayload(id: UUID(), notificationTitle: notificationTitle, notificationSubtitle: notificationSubtitle, notificationId: notificationId, message: message, timestamp: timestamp.utcTimestampToDate(), topic: topic, isHtml: isHtml, isTestMessage: isTestMessage)
                self.delegate?.didFinishLoadingSingleNotification(notificationId: notificationId, notification: payload)
            } else {
                self.logger.error("Notification with ID \(notificationId) does not exist")
            }
        }
    }

    func addCommentToNotification(withId: String, comment: String) {
        let commentPayload = NotificationCommentPayload(comment: comment, username: userService.getCurrentUsername(), timestamp: Date.now)
        let collectionRef = db.collection(DB_COLLECTION_NOTIFICATION_COMMENTS)
        let documentRef = collectionRef.document(withId).collection("comments").document()
        do {
            try documentRef.setData(from: commentPayload)
            delegate?.didFinishUploadingComment()
        } catch let error {
            logger.error("\(error.localizedDescription)")
        }
    }

    func retrieveCommentsForNotification(with id: String) async throws -> [NotificationCommentPayload] {
        let collectionRef = db.collection(DB_COLLECTION_NOTIFICATION_COMMENTS)
        let commentCollectionRef = collectionRef.document(id).collection("comments")

        do {
            let snapshot = try await commentCollectionRef.getDocuments()

            var payloadList = [NotificationCommentPayload]()
            for document in snapshot.documents {
                do {
                    let payload = try document.data(as: NotificationCommentPayload.self)
                    payloadList.append(payload)
                } catch {
                    self.logger.error("\(error)")
                }
            }

            return payloadList
        } catch {
            self.logger.error("Error while getting snapshot \(error)")
            throw error
        }
    }
}
