//
//  NotificationCommentTableViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 12/11/23.
//

import UIKit

class NotificationCommentTableViewCell: UITableViewCell {

    static let nib = UINib(nibName: "NotificationCommentTableViewCell", bundle: nil)

    static let identifier = K.Nibs.Cells.notificationCommentCell

    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var messageLabel: UILabel!

    @IBOutlet weak var timestampLabel: UILabel!
    
    var payload: NotificationCommentPayload!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
