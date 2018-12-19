//
//  LeftTableViewCell.swift
//  Flash Chat
//
//  Created by Arshin Jain on 12/19/18.
//  Copyright © 2018 Arshin. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {

   // Outlets
    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
}
