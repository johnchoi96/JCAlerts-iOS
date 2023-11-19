//
//  ViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/7/23.
//

import UIKit
import FirebaseMessaging

class AlertsViewController: UIViewController {

    @IBOutlet weak var notificationTable: UITableView!

    private let cloudFirestoreService = CloudFirestoreService.instance

    var notifications: [NotificationPayload] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.register(NotificationTableViewCell.nib, forCellReuseIdentifier: NotificationTableViewCell.identifier)

        cloudFirestoreService.delegate = self
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let payload = notifications[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier) as! NotificationTableViewCell
        cell.notificationPayload = payload
        let timestamp = payload.timestamp
        cell.timestampLabel.text = "\(timestamp.month)-\(timestamp.day)-\(timestamp.year)"
        cell.notificationTitleLabel.text = payload.notificationTitle
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
        self.notifications = notifications
        self.notificationTable.reloadData()
    }
}
