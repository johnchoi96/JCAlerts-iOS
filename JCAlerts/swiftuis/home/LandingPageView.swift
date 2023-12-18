//
//  LandingPage.swift
//  JCAlerts
//
//  Created by John Choi on 12/17/23.
//

import SwiftUI

struct LandingPageView: View {
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal) {
                    HStack(spacing: 15) {
                        ForEach(getDummyData()) { data in
                            Card(payload: data)
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
                .padding()
                NavigationLink(destination: UKAlertsView(), label: {
                    Text("More...")
                })
            }
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}




struct UKAlertsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Create and return your UIKit view controller here
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: AlertsViewController.storyboardIdentifier) as! AlertsViewController
        viewController.title = "Alerts"
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the view controller if needed
    }
}

extension LandingPageView {
    func getDummyData() -> [NotificationPayload] {
        return [
            NotificationPayload(id: UUID(), notificationTitle: "title1", notificationSubtitle: "subtitle1", notificationId: "id1", message: "msg1", timestamp: Date.distantPast, topic: .ALL, isHtml: false, isTestMessage: true),
            NotificationPayload(id: UUID(), notificationTitle: "title2", notificationSubtitle: "subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2subtitle2", notificationId: "id2", message: "msg2", timestamp: Date.distantPast, topic: .METALPRICE, isHtml: false, isTestMessage: true),
            NotificationPayload(id: UUID(), notificationTitle: "title3", notificationSubtitle: "subtitle3", notificationId: "id3", message: "msg3", timestamp: Date.distantPast, topic: .PETFINDER, isHtml: false, isTestMessage: true)
        ]
    }
}

#Preview {
    LandingPageView()
}
