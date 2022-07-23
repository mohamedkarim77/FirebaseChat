//
//  LogOutTableViewCell.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit

class LogOutTableViewCell: UITableViewCell {

    var logout: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
    @IBAction func LogoutButtonPressed(_ sender: Any) {
        logout?()
    }
}
