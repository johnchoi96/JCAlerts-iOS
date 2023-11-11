//
//  NotificationSettingsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/26/23.
//

import UIKit

class NotificationSettingsViewController: UIViewController {

    private let notificationTypes = [
        FCMTopic.PETFINDER,
        FCMTopic.METALPRICE
    ]

    @IBOutlet weak var tableView: UITableView!

    private let fcmInstance = FCMTopicService.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotificationSettingsTableViewCell.nib, forCellReuseIdentifier: NotificationSettingsTableViewCell.identifier)
    }
}

extension NotificationSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSettingsTableViewCell.identifier, for: indexPath) as! NotificationSettingsTableViewCell
        cell.notificationLabel.text = notificationTypes[indexPath.row].getTopicName()
        cell.notificationTopic = notificationTypes[indexPath.row].rawValue
        cell.notificationSwitch.setOn(fcmInstance.topicIsSubscribed(topic: cell.notificationTopic), animated: true)
        return cell
    }
    

}
