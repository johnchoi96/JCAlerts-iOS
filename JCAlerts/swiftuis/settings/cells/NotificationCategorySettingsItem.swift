//
//  NotificationCategorySettingsItem.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI

struct NotificationCategorySettingsItem: View {
    var body: some View {
        NavigationLink(destination: NotificationCategoriesView()) {
            Text("Notification Categories")
        }
    }
}
