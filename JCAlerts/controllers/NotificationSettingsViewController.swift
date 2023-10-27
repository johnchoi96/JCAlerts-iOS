//
//  NotificationSettingsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/26/23.
//

import UIKit

class NotificationSettingsViewController: UIViewController {

    private let notificationTypes = [
        ("Petfinder", "jc-alerts-petfinder"),
        ("MetalPrice", "jc-alerts-metalprice")
    ]

    @IBOutlet weak var tableView: UITableView!

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
        cell.notificationLabel.text = notificationTypes[indexPath.row].0
        cell.notificationTopic = notificationTypes[indexPath.row].1
        cell.notificationSwitch.setOn(UserDefaults.standard.bool(forKey: cell.notificationTopic), animated: false)
        return cell
    }
    

}
