//
//  SettingsViewController.swift
//  JCAlerts
//
//  Created by John Choi on 10/23/23.
//

import UIKit

class SettingsViewController: UIViewController {

    private let items = [
        "Notifications"
    ]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Nibs.Cells.settingsItemCell, for: indexPath) as! SettingsTableViewCell
        cell.cellLabel.text = items[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // unselect cell
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: K.Segues.settingsToNotificationSettings, sender: nil)
    }
}
