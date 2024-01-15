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
                Section(header: Text("Settings")) {
                    SettingsViewCell(cellLabel: item)
                }
                Section(header: Text("App Data")) {
                    AppMetadataCell(label: "App Version:", data: K.Device.appVersion ?? "N/A")
                    AppMetadataCell(label: "Build:", data: K.Device.appBuild ?? "N/A")
                }
                Section(header: Text("Resources")) {
                    ResourceCell(label: "Open Source Repository", url: K.Url.githubLink)
                    ResourceCell(label: "Submit an Issue", url: K.Url.githubNewIssue)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)

        }
    }
}

#Preview {
    SettingsView()
}
