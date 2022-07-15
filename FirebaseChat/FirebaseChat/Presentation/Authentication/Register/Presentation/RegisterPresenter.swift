//
//  RegisterPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation

protocol RegisterPresenterProtocol: AnyObject {
    func registerSuccess()
    func registerFailure(error: Error)
}

class RegisterPresenter {
    
    weak var delegate: RegisterPresenterProtocol?
    
    func register(email: String, password: String) {
        let service = AuthService()
        service.register(email: email, password: password)
    }
    
}
