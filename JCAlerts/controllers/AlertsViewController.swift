//
//  AlertsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/7/23.
//

import UIKit
import FirebaseMessaging
import os

class AlertsViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var notificationTable: UITableView!

    private let cloudFirestoreService = CloudFirestoreService()

    /**
     Human readable dates to list of notification payloads
     The list of notification payloads are sorted in the descending order.
     */
    var categorizedPayloads: [String: [NotificationPayload]] = [:]
    
    var sortedHumanReadableDates: [String] = []

    private lazy var refreshControl = UIRefreshControl()

    private let log = Logger()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadingIndicator.startAnimating()
        loadingIndicator.hidesWhenStopped = true
        self.view.backgroundColor = UIColor(named: K.Colors.backgroundColor)

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
        return sortedHumanReadableDates.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedHumanReadableDates[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortedHumanReadableDates.isEmpty {
            return 0
        }
        let date = sortedHumanReadableDates[section]
        return categorizedPayloads[date]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = sortedHumanReadableDates[indexPath.section]
        let payload = categorizedPayloads[date]![indexPath.row]
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
            FCMTopicService.instance.topicIsSubscribed(topic: payload.topic)
        }
        if !filteredNotifications.isEmpty {
            categorizedPayloads = [:]
            sortedHumanReadableDates = []
            var rawToFormatted: [Date: String] = [:]
            for notification in notifications {
                let humanReadableDate = notification.timestamp.formattedDate
                rawToFormatted[notification.timestamp] = humanReadableDate
                if categorizedPayloads[humanReadableDate] == nil {
                    categorizedPayloads[humanReadableDate] = []
                }
                categorizedPayloads[humanReadableDate]?.append(notification)
            }
            for key in categorizedPayloads.keys {
                categorizedPayloads[key]?.sort(by: { firstPayload, secondPayload in
                    firstPayload.timestamp > secondPayload.timestamp
                })
            }
            // calculate sortedHumanReadableDates
            var formattedDateSet: Set<String> = Set()
            let sortedPairs = rawToFormatted.sorted { pair1, pair2 in
                pair1.key > pair2.key
            }
            for pair in sortedPairs {
                if formattedDateSet.contains(pair.value) {
                    continue
                }
                formattedDateSet.insert(pair.value)
                sortedHumanReadableDates.append(pair.value)
            }
        }
        self.notificationTable.reloadData()
        refreshControl.endRefreshing()
        loadingIndicator.stopAnimating()
        log.info("Finished refreshing notification list")
    }
}

private extension Date {
    var formattedDate: String {
        "\(StringUtil.getStringMonth(month: self.month) ?? "N/A") \(self.day), \(self.year)"
    }
}
