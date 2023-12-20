//
//  UKNotificationDetailView.swift
//  JCAlerts
//
//  Created by John Choi on 12/19/23.
//

import SwiftUI

struct UKNotificationDetailView: UIViewControllerRepresentable {
    var payload: NotificationPayload!
    
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: NotificationDetailViewController.storyboardIdentifier) as! NotificationDetailViewController
        viewController.notificationPayload = payload
        if let label = viewController.topicNameLabel {
            label.text = payload.topic.getTopicName()
        }
        if let label = viewController.messageView {
            label.text = ""
        }
        if let label = viewController.timestampLabel {
            label.text = payload.timestamp.formattedDate
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the view controller if needed
    }
}
