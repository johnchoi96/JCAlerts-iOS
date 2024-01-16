//
//  ContentView.swift
//  JCAlerts
//
//  Created by John Choi on 12/18/23.
//

import SwiftUI
import TipKit

struct ContentView: View {
    
    var firstTimeTip = FirstTimeWelcomeTip()

    var body: some View {
        TipView(firstTimeTip)
        TabView {
            LandingPageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SettingsView()
                .task {
                    if UserSettingService.instance.isDebugMode {
                        try? Tips.resetDatastore()
                    }
                    try? Tips.configure()
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }

        }
    }
}

#Preview {
    ContentView()
        .task {
              try? Tips.resetDatastore()
              try? Tips.configure()
        }
}
