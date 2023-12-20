//
//  NotificationDetailViewController.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import UIKit

class NotificationDetailViewController: UIViewController {

    static let storyboardIdentifier = "NotificationDetailViewController"

    @IBOutlet weak var topicNameLabel: UILabel!
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var timestampLabel: UILabel!

    var notificationPayload: NotificationPayload!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(named: K.Colors.backgroundColor)
        if notificationPayload.isHtml {
            messageView.attributedText = notificationPayload.message.htmlToAttributedString
            messageView.textColor = UIColor(named: K.Colors.inverseTextColor)
        } else {
            messageView.text = notificationPayload.message
        }
        messageView.layer.cornerRadius = 15
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

    @IBAction func commentsTapped(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.notificationDetailToComments, sender: notificationPayload)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.notificationDetailToComments {
            let vc = segue.destination as! NotificationCommentsViewController
            vc.notificationPayload = sender as? NotificationPayload
        }
    }

    @IBAction func shareTapped(_ sender: UIBarButtonItem) {
        let title = "Share"
        let message = "What would you like to share?"
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let textAction = UIAlertAction(title: "Text", style: .default) { action in
            let text = self.getShareText()
            self.presentShareSheet(content: text, barButton: sender)
        }
        let screenShotAction = UIAlertAction(title: "Screen Shot", style: .default) { action in
            guard let screenShot = self.getScreenShot() else {
                let errorAlert = UIAlertController(title: "Error", message: "Could not get screenshot. No action will be taken.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                errorAlert.addAction(okAction)
                if let popoverView = errorAlert.popoverPresentationController {
                    popoverView.sourceView = self.view
                    popoverView.barButtonItem = sender
                }
                self.present(errorAlert, animated: true)
                return
            }
            self.presentShareSheet(content: screenShot, barButton: sender)
        }
        alertView.addAction(textAction)
        alertView.addAction(screenShotAction)
        if let popoverView = alertView.popoverPresentationController {
            popoverView.sourceView = self.view
            popoverView.barButtonItem = sender
        }
        present(alertView, animated: true)
    }

    private func presentShareSheet(content: Any, barButton: UIBarButtonItem) {
        let shareAll = [content]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)

        //avoiding to crash on iPad
        if let popoverView = activityViewController.popoverPresentationController {
            popoverView.sourceView = self.view
            popoverView.barButtonItem = barButton
        }
        present(activityViewController, animated: true, completion: nil)
    }

    private func getShareText() -> String {
        let title = "Title: \(notificationPayload.notificationTitle)"
        let subtitle = "Subtitle: \(notificationPayload.notificationSubtitle)"
        let timestamp = "Date: \(notificationPayload.timestamp.formattedDate)"
        let separator = "-----------------------"
        let content = "Content:\n\(separator)\n\(messageView.text ?? "")\n\(separator)"
        let payloadList = [
            title,
            subtitle,
            timestamp,
            content
        ]
        return payloadList.joined(separator: "\n")
    }

    private func getScreenShot() -> UIImage? {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
