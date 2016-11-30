//
//  UserCell.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 11/30/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userTypeLabel: UILabel!
    @IBOutlet var userImg: UIImageView!
    
    func setLabels() {
        let nameFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        let typeFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        nameLabel.font = nameFont
        userTypeLabel.font = typeFont
    }
}
