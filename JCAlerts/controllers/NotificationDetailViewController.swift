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
        let timestamp = notificationPayload.timestamp
        timestampLabel.text = formatTimestamp(timestamp: timestamp)
    }

    private func formatTimestamp(timestamp: Date) -> String {
        let month = StringUtil.getStringMonth(month: timestamp.month) ?? "N/A"
        let day = timestamp.day
        let year = timestamp.year
        let hour = timestamp.get12FormatHour
        let minute = timestamp.minute
        let formattedMinute = String(format: "%02d", minute)
        let isAm = timestamp.isAm

        return "\(month) \(day), \(year) at \(hour):\(formattedMinute) \(isAm)"
    }

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}
