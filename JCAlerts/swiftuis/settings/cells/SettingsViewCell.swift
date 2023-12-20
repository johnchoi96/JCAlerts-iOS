//
//  SettingsViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI

struct SettingsViewCell: View {
    var cellLabel: String

    var body: some View {
        NavigationLink(destination: NotificationCategoriesView()) {
            Text(cellLabel)
        }
    }
}

#Preview {
    SettingsViewCell(cellLabel: "DEMO")
}
