//
//  FCMTopicService.swift
//  JCAlerts
//
//  Created by John Choi on 10/28/23.
//

import Foundation
import FirebaseMessaging
import os

class FCMTopicService {
    static let instance = FCMTopicService()

    private let TOPIC_KEY = "fcm-topics"

    private let DEFAULT_FCM_TOPIC = "jc-alerts-all"

    private let fcmInstance = Messaging.messaging()

    private let log = Logger()

    private init() {}
    
    func subscribe(toTopic topic: String) {
        // save list of topics to UserDefaults
        var topics = getTopics()
        // check to see if the topic exists in the list of topics
        if topics.contains(topic) {
            // do nothing
            log.warning("Already subscribed to the \(topic) topic. This will not be subscribed again.")
            return
        }
        topics.append(topic)
        fcmInstance.subscribe(toTopic: topic) { error in
            if error != nil {
                // do something
                print(error!)
            } else {
                print("successfully subed")
            }
        }
        setTopics(as: &topics)
    }

    func unsubscribe(fromTopic topic: String) {
        var topics = getTopics()
        // find index of topic
        var index = -1
        for i in 0..<topics.count {
            if topics[i] == topic {
                index = i
                break
            }
        }
        if index == -1 {
            fatalError("Something went wrong while trying to unsubscribe \(topic) topic")
        }
        // remove from the index
        topics.remove(at: index)
        // unsub from fcm
        fcmInstance.unsubscribe(fromTopic: topic) { error in
            if let error = error {
                print(error)
            } else {
                print("succcessfully unsubbed")
            }
        }
        // save the new list of topics
        setTopics(as: &topics)
    }

    func getTopics() -> [String] {
        return UserDefaults.standard.stringArray(forKey: TOPIC_KEY) ?? [DEFAULT_FCM_TOPIC]
    }

    func topicIsSubscribed(topic: String) -> Bool {
        return getTopics().contains(topic)
    }

    func restoreSubscription() {
        for topic in getTopics() {
            fcmInstance.subscribe(toTopic: topic)
        }
    }

    private func setTopics(as topicsList: inout [String]) {
        if topicsList.count == 0 {
            topicsList.append(DEFAULT_FCM_TOPIC)
        }
        if !topicsList.contains(DEFAULT_FCM_TOPIC) {
            topicsList.insert(DEFAULT_FCM_TOPIC, at: 0)
        }
        UserDefaults.standard.set(topicsList, forKey: TOPIC_KEY)
    }
}
