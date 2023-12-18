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
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                NavigationLink(destination: UKAlertsView()) {
                    Text("Go to Other Screen")
                }
                .padding()
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

#Preview {
    LandingPageView()
}
