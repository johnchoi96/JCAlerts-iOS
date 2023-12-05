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

    private let cloudFirestoreService = CloudFirestoreService()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Notification Detail"
        textView.text = "Loading..."
        textView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor(named: K.Colors.backgroundColor)

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
            textView.textColor = UIColor(named: K.Colors.inverseTextColor)
        } else {
            self.textView.text = notification.message
        }
    }
}
