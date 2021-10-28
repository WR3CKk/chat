//
//  SenderMessageCell.swift
//  Chat
//
//  Created by Alexander on 07.09.2021.
//

import UIKit

class SenderMessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var senderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        senderImage.layer.cornerRadius = senderImage.frame.size.width / 2
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
        messageBubble.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
