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
        }
    }

    func getTopicValue() -> String {
        return self.rawValue
    }
}
