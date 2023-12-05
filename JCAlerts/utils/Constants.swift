//
//  Constants.swift
//  JCAlerts
//
//  Created by John Choi on 10/23/23.
//

import Foundation

struct K {
    struct Nibs {
        struct Views {
            static let notificationDisplayView = "notificationDisplayView"
        }
        struct Cells {
            static let settingsItemCell = "settingsItemCell"
            static let notificationSettingsCell = "notificationSettingsCell"
            static let notificationCell = "notificationCell"
        }
    }

    struct Segues {
        static let settingsToNotificationSettings = "settingsToNotificationSettings"
        static let alertsToNotificationDetail = "alertsToNotificationDetail"
    }

    struct Colors {
        static let htmlTextColor = "HtmlTextColor"
    }
}
