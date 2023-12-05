//
//  NotificationSettingsTableViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 10/26/23.
//

import UIKit
import FirebaseMessaging
import os

class NotificationSettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var notificationSwitch: UISwitch!

    @IBOutlet weak var notificationLabel: UILabel!

    var notificationTopic: String!

    static let nib = UINib(nibName: "NotificationSettingsTableViewCell", bundle: nil)

    static let identifier = K.Nibs.Cells.notificationSettingsCell

    private let fcmTopicService = FCMTopicService.instance

    private let log = Logger()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchTapped(_ sender: UISwitch) {
        guard let topic = FCMTopic.getTopic(with: notificationTopic) else {
            log.error("Invalid topic")
            return
        }
        if sender.isOn {
            fcmTopicService.subscribe(toTopic: topic)
        } else {
            fcmTopicService.unsubscribe(fromTopic: topic)
        }
        log.info("\(self.fcmTopicService.getTopicsAsStrings())")
    }
    
}
