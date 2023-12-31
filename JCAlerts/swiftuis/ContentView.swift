//
//  ContentView.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isFirstTimeRunning = UserSettingService.instance.getFirstTimeRunning()

    private let WELCOME_MSG = "Welcome to JCAlerts!"
    private let WELCOME_MSG_BODY = """
For the first time setup, please go to the Settings tab and configure notification subscriptions
"""

    var body: some View {
        TabView {
            LandingPageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .alert(WELCOME_MSG, isPresented: $isFirstTimeRunning) {
            Button(role: .cancel) {
                // handle action
                isFirstTimeRunning = false
                FCMTopicService.instance.subscribeToAllTopic()
                UserSettingService.instance.setFirstTimeRunningToFalse()
            } label: {
                Text("OK")
            }

        } message: {
            Text(WELCOME_MSG_BODY)
        }
    }
}

#Preview {
    ContentView()
}
