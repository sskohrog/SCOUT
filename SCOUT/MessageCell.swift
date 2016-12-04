//
//  MessageCell.swift
//  SCOUT
//
//  Created by Sophie Kohrogi on 12/3/16.
//  Copyright © 2016 ScoutApp. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userImg: UIImageView!
    
    func setLabels() {
        let nameFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        
        nameLabel.font = nameFont
    }
}
