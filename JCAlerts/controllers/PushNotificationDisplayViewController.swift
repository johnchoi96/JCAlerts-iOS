//
//  NotificationDisplayViewController.swift
//  JCAlerts
//
//  Created by John Choi on 11/11/23.
//

import UIKit

class PushNotificationDisplayViewController: UIViewController {

    static let nib = UINib(nibName: "PushNotificationDisplayViewController", bundle: nil)
    static let identifier = K.Nibs.Views.notificationDisplayView

    @IBOutlet weak var textView: UITextView!
    
    var payload: [AnyHashable: Any]!

    private let cloudFirestoreService = CloudFirestoreService.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Notification Detail"
        textView.text = "Loading..."

        cloudFirestoreService.delegate = self

        DispatchQueue.main.async {
            let notificationId = self.payload["notification-id"] as! String
            self.cloudFirestoreService.retrieveNotificationPayload(notificationId: notificationId)
        }
    }

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension PushNotificationDisplayViewController: CloudFirestoreDelegate {
    func didFinishLoadingSingleNotification(notificationId: String, notification: NotificationPayload) {
        if notification.isHtml {
            self.textView.attributedText = notification.message.htmlToAttributedString
        } else {
            self.textView.text = notification.message
        }
    }
}