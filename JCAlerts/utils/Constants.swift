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
            static let notificationCommentCell = "notificationCommentCell"
        }
    }

    struct Segues {
        static let settingsToNotificationSettings = "settingsToNotificationSettings"
        static let alertsToNotificationDetail = "alertsToNotificationDetail"
        static let notificationDetailToComments = "notificationDetailToComments"
    }

    struct Colors {
        static let inverseTextColor = "InverseTextColor"
        static let defaultTextColor = "DefaultTextColor"
        static let backgroundColor = "BackgroundColor"
    }

    struct Images {
        static let jcAlertsLogo = "jcalerts_logo"
    }

    struct Device {
        static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
}
