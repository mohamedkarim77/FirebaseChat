//
//  RegisterPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth

protocol RegisterPresenterProtocol: AnyObject {
    func registerSuccess()
    func registerFailure(error: Error)
}

class RegisterPresenter {
    
    weak var delegate: RegisterPresenterProtocol?
    
    func register(email: String, password: String) {
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            guard let result = authResult, error == nil else {
                print("Failed to register: \(String(describing: error))")
                return
            }
            let user = result.user
            print("Registered User: \(user)")
        }
    }
    
}
