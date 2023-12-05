//
//  AlertsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/7/23.
//

import UIKit
import FirebaseMessaging

class AlertsViewController: UIViewController {

    @IBOutlet weak var notificationTable: UITableView!

    private let cloudFirestoreService = CloudFirestoreService()

    var dateAndPayloads: [String: [NotificationPayload]] = [:]
    
    var orderedDates: [String] = []

    private lazy var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationTable.backgroundColor = .clear
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)

        cloudFirestoreService.delegate = self
        cloudFirestoreService.fetchNotificationPayloads()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshNotifications(_:)), for: .valueChanged)
        notificationTable.addSubview(refreshControl)
    }

    @objc private func refreshNotifications(_ sender: AnyObject) {
        cloudFirestoreService.fetchNotificationPayloads()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.alertsToNotificationDetail {
            let vc = segue.destination as! NotificationDetailViewController
            vc.notificationPayload = sender as? NotificationPayload
        }
    }
}

extension AlertsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderedDates.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderedDates[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderedDates.isEmpty {
            return 0
        }
        let date = orderedDates[section]
        return dateAndPayloads[date]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = orderedDates[indexPath.section]
        let payload = dateAndPayloads[date]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier) as! NotificationTableViewCell
        cell.notificationPayload = payload
        cell.notificationSubtitleLabel.text = payload.notificationSubtitle
        cell.notificationTitleLabel.text = payload.notificationTitle
        cell.topicLabel.text = "#\(payload.topic.getTopicName().lowercased())"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // deselect cell
        tableView.deselectRow(at: indexPath, animated: true)
        // display modal
        let cell = tableView.cellForRow(at: indexPath) as! NotificationTableViewCell
        let notificationPayload = cell.notificationPayload
        performSegue(withIdentifier: K.Segues.alertsToNotificationDetail, sender: notificationPayload)
    }
}

extension AlertsViewController: CloudFirestoreDelegate {
    func didFinishLoadingAll(notifications: [NotificationPayload], notificationsDict: [String : NotificationPayload]) {
        let filteredNotifications = notifications.filter { payload in
            FCMTopicService.instance.topicIsSubscribed(topic: payload.topic.getTopicValue())
        }
        if !filteredNotifications.isEmpty {
            var dateSet = Set<String>() // contains Month dd, yyyy
            for notification in filteredNotifications {
                // check if we've seen this date before
                let formattedDate = notification.timestamp.formattedDate
                if dateSet.contains(formattedDate) {
                    dateAndPayloads[formattedDate]!.append(notification)
                } else {
                    dateSet.insert(formattedDate)
                    dateAndPayloads[formattedDate] = [notification]
                }
            }
            orderedDates = dateSet.sorted().reversed()
        }
        self.notificationTable.reloadData()
        refreshControl.endRefreshing()
    }
}

private extension Date {
    var formattedDate: String {
        "\(StringUtil.getStringMonth(month: self.month) ?? "N/A") \(self.day), \(self.year)"
    }
}
