//
//  UIButton+Extension.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import Foundation
import UIKit

extension UIButton {
   
    func setupButton(title: String) {
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = .systemBlue
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
       // titleLabel?.font = UIFont(name: "Poppins-Bold", size: 15)
        titleLabel?.tintColor = .white
        titleLabel?.text = title
    }
}
