//
//  LoginPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth

protocol LoginPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailure(error: Error)
}

class LoginPresenter {
    
    weak var delegate: LoginPresenterProtocol?
    
    func login(email: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard let result = authResult, error == nil else {
                print("Failed to login: \(String(describing: error))")
                return}
            let user = result.user
            print("Succeful login: \(user)")
        }
    }
    
}
