//
//  SettingsView.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI

struct SettingsView: View {

    private let items = [
        "Notification Categories"
    ]

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                SettingsViewCell(cellLabel: item)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    SettingsView()
}
