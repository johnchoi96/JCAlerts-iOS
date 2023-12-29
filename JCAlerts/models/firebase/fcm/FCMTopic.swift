//
//  FCMTopic.swift
//  JCAlerts
//
//  Created by John Choi on 11/11/23.
//

import Foundation

enum FCMTopic: String {

    case ALL = "jc-alerts-all"
    case PETFINDER = "jc-alerts-petfinder"
    case METALPRICE = "jc-alerts-metalprice"
    case CFB = "jc-alerts-cfb"
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
        }
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
        } else {
            return nil
        }
    }
}
