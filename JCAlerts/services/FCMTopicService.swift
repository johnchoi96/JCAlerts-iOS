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

    private let DEFAULT_FCM_TOPIC = FCMTopic.ALL

    private let fcmInstance = Messaging.messaging()

    private let log = Logger()

    var delegate: FCMTopicDelegate?

    private init() {}
    
    func subscribe(toTopic topic: FCMTopic) {
        // save list of topics to UserDefaults
        var topics = getTopicsAsStrings()
        // check to see if the topic exists in the list of topics
        if topics.contains(topic.getTopicValue()) {
            // do nothing
            log.warning("Already subscribed to the \(topic.getTopicName()) topic. This will not be subscribed again.")
            return
        }
        topics.append(topic.getTopicValue())
        fcmInstance.subscribe(toTopic: topic.getTopicValue()) { error in
            if error != nil {
                // do something
                print(error!)
            } else {
                print("successfully subed")
            }
        }
        setTopics(as: &topics)
        delegate?.didUpdateTopic()
    }

    func unsubscribe(fromTopic topic: FCMTopic) {
        var topics = getTopicsAsStrings()
        // find index of topic
        var index = -1
        for i in 0..<topics.count {
            if topics[i] == topic.getTopicValue() {
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
        fcmInstance.unsubscribe(fromTopic: topic.getTopicValue()) { error in
            if let error = error {
                print(error)
            } else {
                print("succcessfully unsubbed")
            }
        }
        // save the new list of topics
        setTopics(as: &topics)
        delegate?.didUpdateTopic()
    }

    func getTopicsAsStrings() -> [String] {
        return UserDefaults.standard.stringArray(forKey: TOPIC_KEY) ?? [DEFAULT_FCM_TOPIC.getTopicValue()]
    }

    func topicIsSubscribed(topic: FCMTopic) -> Bool {
        return getTopicsAsStrings().contains(topic.getTopicValue())
    }

    func restoreSubscription() {
        for topic in getTopicsAsStrings() {
            fcmInstance.subscribe(toTopic: topic)
        }
    }

    private func setTopics(as topicsList: inout [String]) {
        if topicsList.count == 0 {
            topicsList.append(DEFAULT_FCM_TOPIC.getTopicValue())
        }
        if !topicsList.contains(DEFAULT_FCM_TOPIC.getTopicValue()) {
            topicsList.insert(DEFAULT_FCM_TOPIC.getTopicValue(), at: 0)
        }
        UserDefaults.standard.set(topicsList, forKey: TOPIC_KEY)
    }
}
