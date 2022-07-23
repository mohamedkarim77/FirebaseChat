//
//  ImageTableViewCell.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 17/07/2022.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.image = UIImage(named: "logo")
        profileImageView?.addCircleCornerRadius()
    }

}
