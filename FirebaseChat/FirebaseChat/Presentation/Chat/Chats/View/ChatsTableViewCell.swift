//
//  TableViewCell.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView.addCircleCornerRadius()
    }
    
   var imageurl: URL? {
       didSet {
           if let url = imageurl {
               userImageView.loadImage(url)
           }
       }
    }
    
    var chatModel: Chat! {
        didSet {
            nameLabel.text = chatModel.name
            messageLabel.text = chatModel.latestMessage.text
        }
    }
    
}
