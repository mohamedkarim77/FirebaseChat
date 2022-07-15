//
//  LoginPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation

protocol LoginPresenterProtocol: AnyObject {
    func loginSuccess()
    func loginFailure(error: Error)
}

class LoginPresenter {
    
    weak var delegate: LoginPresenterProtocol?
    
    func login(email: String, password: String) {
        let service = AuthService()
        service.login(email: email, password: password)
    }
    
}
