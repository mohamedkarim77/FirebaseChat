//
//  UserDataTableViewCell.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {

    @IBOutlet weak var userDataLabel: UILabel!{
        didSet{
            userDataLabel.text = userEmail
    }
        
    }
    var userEmail = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
