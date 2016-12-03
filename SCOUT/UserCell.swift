
//
//  UserCell.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 11/30/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userTypeLabel: UILabel!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    func setLabels() {
        let nameFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        let typeFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        
        nameLabel.font = nameFont
        userTypeLabel.font = typeFont
    }
}
