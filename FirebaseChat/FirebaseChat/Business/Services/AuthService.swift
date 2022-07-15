//
//  File.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    func login(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to login: \(String(describing: error))")
                return}
            let user = result.user
            print("Succeful login: \(user)")
        }
    }
    
    func register(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let result = authResult, error == nil else {
                print("Failed to register: \(String(describing: error))")
                return
            }
            let user = result.user
            print("Registered User: \(user)")
        }
    }
}
