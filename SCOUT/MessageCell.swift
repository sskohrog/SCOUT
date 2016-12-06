//
//  MessageCell.swift
//  SCOUT
//
//  Created by Mohammed Islubee & Sophie Kohrogi on 12/3/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//
//  Sets the font style of the name of message

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userImg: UIImageView!
    
    func setLabels() {
        let nameFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        nameLabel.font = nameFont
    }
}
