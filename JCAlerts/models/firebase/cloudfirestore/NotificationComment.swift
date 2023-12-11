//
//  NotificationComment.swift
//  JCAlerts
//
//  Created by John Choi on 12/10/23.
//

import Foundation

struct NotificationCommentPayload: Codable {
    var comment: String

    var username: String

    var timestamp: Date

    enum CodingKeys: String, CodingKey {
        case comment

        case username

        case timestamp
    }
}

extension NotificationCommentPayload: Comparable {
    static func < (lhs: NotificationCommentPayload, rhs: NotificationCommentPayload) -> Bool {
        return lhs.timestamp < rhs.timestamp
    }
}
