//
//  NotificationTableViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 11/17/23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "NotificationTableViewCell", bundle: nil)

    static let identifier = K.Nibs.Cells.notificationCell

    var notificationPayload: NotificationPayload!

    @IBOutlet weak var notificationSubtitleLabel: UILabel!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.accessoryType = .detailButton
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
