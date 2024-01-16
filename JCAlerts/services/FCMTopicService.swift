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

    private var DEFAULT_FCM_TOPICS: [FCMTopic]

    private var DEFAULT_FCM_TOPICS_STRING: [String] {
        DEFAULT_FCM_TOPICS.map { topic in
            topic.getTopicValue()
        }
    }

    private let fcmInstance = Messaging.messaging()

    private let log = Logger()

    var delegate: FCMTopicDelegate?

    private init() {
        DEFAULT_FCM_TOPICS = []
        DEFAULT_FCM_TOPICS.append(.ALL)
        if UserSettingService.instance.isDebugMode {
            DEFAULT_FCM_TOPICS.append(.TEST_NOTIFICATION)
        }
    }
    
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
                self.log.warning("\(error!)")
            } else {
                self.log.info("successfully subed")
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
            log.warning("Could not find \(topic.getTopicValue()) topic to unsubscribe. Aborting")
            return
        }
        // remove from the index
        topics.remove(at: index)
        // unsub from fcm
        fcmInstance.unsubscribe(fromTopic: topic.getTopicValue()) { error in
            if let error = error {
                self.log.info("\(error)")
            } else {
                self.log.info("succcessfully unsubbed")
            }
        }
        // save the new list of topics
        setTopics(as: &topics)
        delegate?.didUpdateTopic()
    }

    func getTopicsAsStrings() -> [String] {
        return UserDefaults.standard.stringArray(forKey: TOPIC_KEY) ?? DEFAULT_FCM_TOPICS_STRING
    }

    func topicIsSubscribed(topic: FCMTopic) -> Bool {
        return getTopicsAsStrings().contains(topic.getTopicValue())
    }

    func topicIsSubscribed(topic: String) -> Bool {
        return getTopicsAsStrings().contains(topic)
    }

    func restoreSubscription() {
        for topic in getTopicsAsStrings() {
            fcmInstance.subscribe(toTopic: topic)
        }
        if UserSettingService.instance.isDebugMode {
            subscribe(toTopic: .TEST_NOTIFICATION)
        } else {
            unsubscribe(fromTopic: .TEST_NOTIFICATION)
        }
    }

    private func setTopics(as topicsList: inout [String]) {
        if topicsList.count == 0 {
            for defaultTopic in DEFAULT_FCM_TOPICS_STRING {
                topicsList.append(defaultTopic)
            }
        }
        // if topicsList does not contain the default topics
        let defaultListSet = Set(DEFAULT_FCM_TOPICS_STRING)
        let topicsListSet = Set(topicsList)
        let intersection = defaultListSet.intersection(topicsListSet)
        let missingTopicSet = defaultListSet.subtracting(intersection)

        for missingTopic in missingTopicSet {
            topicsList.insert(missingTopic, at: 0)
        }
        UserDefaults.standard.set(topicsList, forKey: TOPIC_KEY)
    }

    func subscribeToAllTopic() {
        FCMTopic.getAllTopic().forEach { topic in
            subscribe(toTopic: topic)
        }
    }
}
