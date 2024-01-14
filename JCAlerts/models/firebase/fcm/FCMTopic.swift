//
//  FCMTopic.swift
//  JCAlerts
//
//  Created by John Choi on 11/11/23.
//

import Foundation

enum FCMTopic: String, CaseIterable {

    case ALL = "jc-alerts-all"
    case PETFINDER = "jc-alerts-petfinder"
    case METALPRICE = "jc-alerts-metalprice"
    case CFB = "jc-alerts-cfb"
    case TEST_NOTIFICATION = "jc-alerts-test"
}

extension FCMTopic {

    func getTopicName() -> String {
        switch self {
        case .ALL:
            return "All"
        case .PETFINDER:
            return "Petfinder"
        case .METALPRICE:
            return "MetalPrice"
        case .CFB:
            return "CFB"
        case .TEST_NOTIFICATION:
            return "TEST"
        }
    }

    static func getAllTopic() -> [FCMTopic] {
        var allTopic = FCMTopic.allCases
        if !UserSettingService.instance.isDebugMode {
            allTopic = allTopic.filter { topic in
                topic != .TEST_NOTIFICATION
            }
        }
        return allTopic
    }

    func getTopicValue() -> String {
        return self.rawValue
    }

    static func getTopic(with string: String) -> FCMTopic? {
        if string == FCMTopic.ALL.getTopicName() || string == FCMTopic.ALL.getTopicValue() {
            return .ALL
        } else if string == FCMTopic.PETFINDER.getTopicName() || string == FCMTopic.PETFINDER.getTopicValue() {
            return .PETFINDER
        } else if string == FCMTopic.METALPRICE.getTopicName() || string == FCMTopic.METALPRICE.getTopicValue() {
            return .METALPRICE
        } else if string == FCMTopic.CFB.getTopicName() || string == FCMTopic.CFB.getTopicValue() {
            return .CFB
        } else if string == FCMTopic.TEST_NOTIFICATION.getTopicName() || string == FCMTopic.TEST_NOTIFICATION.getTopicValue() {
            return .TEST_NOTIFICATION
        } else {
            return nil
        }
    }
}
