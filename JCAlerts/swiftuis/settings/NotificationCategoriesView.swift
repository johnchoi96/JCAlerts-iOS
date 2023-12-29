//
//  NotificationCategoriesView.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI

struct NotificationCategoriesView: View {
    private let notificationTypes = [
        FCMTopic.PETFINDER,
        FCMTopic.METALPRICE,
        FCMTopic.CFB
    ]

    var body: some View {
        List(notificationTypes, id: \.self) { type in
            NotificationCategoryCell(topic: type)
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    NotificationCategoriesView()
}
