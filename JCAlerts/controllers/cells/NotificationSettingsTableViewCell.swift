//
//  NotificationSettingsTableViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 10/26/23.
//

import UIKit
import FirebaseMessaging

class NotificationSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationSwitch: UISwitch!

    @IBOutlet weak var notificationLabel: UILabel!
    var notificationTopic: String!

    static let nib = UINib(nibName: "NotificationSettingsTableViewCell", bundle: nil)
    static let identifier = K.Cells.notificationSettingsCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchTapped(_ sender: UISwitch) {
        print(sender.isOn)
        print(notificationTopic!)
        if sender.isOn {
            Messaging.messaging().subscribe(toTopic: notificationTopic)
        } else {
            Messaging.messaging().unsubscribe(fromTopic: notificationTopic)
        }
        UserDefaults.standard.set(sender.isOn, forKey: notificationTopic)
    }
    
}
