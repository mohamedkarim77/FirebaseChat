//
//  File.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation

// MARK: - User
struct User: Decodable {
    let email: String?
    let firstName: String?
    let lastName: String?
    let phone: String?
    let id: Int?

    
    
    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case phone
        case id
    }
}
