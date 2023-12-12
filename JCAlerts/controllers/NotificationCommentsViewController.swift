//
//  NotificationCommentsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 12/11/23.
//

import UIKit
import IQKeyboardManagerSwift
import os

class NotificationCommentsViewController: UIViewController {

    @IBOutlet weak var commentsTable: UITableView!

    @IBOutlet weak var commentTextField: UITextField!

    let cfService = CloudFirestoreService()

    var comments: [NotificationCommentPayload] = []

    var notificationPayload: NotificationPayload!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        IQKeyboardManager.shared.enable = true
        self.view.backgroundColor = UIColor(named: K.Colors.backgroundColor)
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.register(NotificationCommentTableViewCell.nib, forCellReuseIdentifier: NotificationCommentTableViewCell.identifier)

        cfService.delegate = self

        reloadComments()
    }

    private func reloadComments() {
        Task { @MainActor in
            do {
                let comments = try await cfService.retrieveCommentsForNotification(with: notificationPayload.notificationId)
                // Handle the comments array as needed
                self.comments = comments.sorted(by: { firstPayload, secondPayload in
                    firstPayload.timestamp < secondPayload.timestamp
                })
                commentsTable.reloadData()
            } catch {
                // Handle errors
                let logger = Logger()
                logger.error("Error: \(error)")
            }
        }
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        if let text = commentTextField.text {
            cfService.addCommentToNotification(withId: notificationPayload.notificationId, comment: text)

            commentTextField.resignFirstResponder()
            commentTextField.text = ""
        }
    }
}

extension NotificationCommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCommentTableViewCell.identifier, for: indexPath) as! NotificationCommentTableViewCell
        let comment = comments[indexPath.row]
        cell.messageLabel.text = comment.comment
        cell.payload = comment
        cell.timestampLabel.text = comment.timestamp.formatted()
        cell.usernameLabel.text = comment.username
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NotificationCommentsViewController: CloudFirestoreDelegate {
    func didFinishUploadingComment() {
        reloadComments()
    }
}
