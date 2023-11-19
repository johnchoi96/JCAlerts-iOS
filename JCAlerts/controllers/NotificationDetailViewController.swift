//
//  NotificationDetailViewController.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import UIKit

class NotificationDetailViewController: UIViewController {
    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var timestampLabel: UILabel!

    var notificationPayload: NotificationPayload!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Notification Detail"
        if notificationPayload.isHtml {
            messageView.attributedText = notificationPayload.message.htmlToAttributedString
        } else {
            messageView.text = notificationPayload.message
        }
        topicNameLabel.text = notificationPayload.topic.getTopicName()
        timestampLabel.text = notificationPayload.timestamp
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
