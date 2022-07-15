//
//  UITextField+Extension.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    func setupTextField() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        clipsToBounds = true
      //  font = UIFont(name: "Poppins-Regular", size: 15)
    }
   
}
