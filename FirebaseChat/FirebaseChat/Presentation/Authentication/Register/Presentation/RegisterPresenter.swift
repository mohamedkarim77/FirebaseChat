//
//  RegisterPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol RegisterPresenterProtocol: AnyObject {
    func registerSuccess()
    func registerFailure(error: Error)
    func registerExists()
}

class RegisterPresenter {
    
    weak var delegate: RegisterPresenterProtocol?
    
    func register(firstName: String,lastName: String, email: String, password: String, profileImage: UIImage) {
        DatabaseManager.shared.userExists(with: email) { [weak self] exists in
            guard let self = self else { return }
            guard !exists else {
                self.delegate?.registerExists()
                //showAuthAlert(message: "User Email Already Exists")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {  authResult, error in
              
                guard let result = authResult, error == nil else {
                    print("Failed to register: \(String(describing: error))")
                    self.delegate?.registerFailure(error: error!)
                    return
                }
                
                let user = result.user
                let chatUser = User(email: email,
                                    firstName: firstName,
                                    lastName: lastName)
                DatabaseManager.shared.insertUser(with: chatUser, completion: { success in
                    if success {
                        // upload image
                        guard let data = profileImage.pngData() else { return }
                        let fileName = chatUser.profileImageFileName
                        StorageManager.shared.uploadProfileImage(data: data, fileName: fileName, completion: {result in
                            switch result {
                            case .success(let downloadUrl):
                                UserDefaults.standard.setValue(downloadUrl, forKey: "PROFILE_IMAGE_URL")
                                print(downloadUrl)
                            case .failure(let error):
                                print(error)
                            }
                        })
                    }
                    
                })
                print("Registered User: \(String(describing: user))")
                self.delegate?.registerSuccess()
            }
        }
    }
    
}
