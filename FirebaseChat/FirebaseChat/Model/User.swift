//
//  File.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation

// MARK: - User
struct User {
    let email: String
    let firstName: String
    let lastName: String

    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    var profileImageFileName: String {
        let image = "\(safeEmail)_profile_image.png"
        print(image)
        return image
    }

}
