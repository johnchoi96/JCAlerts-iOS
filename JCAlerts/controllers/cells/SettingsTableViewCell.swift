//
//  SettingsTableViewCell.swift
//  JCAlerts
//
//  Created by John Choi on 10/26/23.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!

    static let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)

    static let identifier = K.Nibs.Cells.settingsItemCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
