//
//  ProfilePresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth
import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    func userSuccess()
    func userFailure(_ error: Error)
    func imageSuccess()
    func imageFailure(_ error: Error)
}

class ProfilePresenter {
    
    weak var delegate: ProfilePresenterProtocol?
    let profileImageCellID = "ProfileImageTableViewCell"
    let userDataCellID = "UserDataTableViewCell"
    let logoutCellID = "LogOutTableViewCell"
    var userEmail: String?
    var profileImageUrl: String?
    var profileImageData = Data()
 
//    func getUser(){
//        guard let  userEmail = FirebaseAuth.Auth.auth().currentUser?.email,
//              !userEmail.isEmpty, let profileImageUrl = UserDefaults.standard.string(forKey: "PROFILE_IMAGE_URL") else {
//            print(self.userEmail ?? "")
//            delegate?.userFailure()
//            return
//        }
//        self.profileImageUrl = profileImageUrl
//        self.userEmail = userEmail
//        print(self.userEmail ?? "")
//        delegate?.userSuccess()
//    }
    
    func getImage() {
        guard let email = UserDefaults.standard.value(forKey: "EMAIL") as? String else {
            return 
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        print(safeEmail)
        let filename = safeEmail + "_profile_image.png"
        let path = "images/"+filename
        let storageManager = StorageManager.shared
        storageManager.downloadURL(for: path) { result in
            switch result {
            case .success(let url):
                URLSession.shared.dataTask(with: url,completionHandler:  { [weak self] data, _, error in
                    guard let self = self, let data = data, error == nil else {
                        self?.delegate?.imageFailure(error!)
                        return
                    }
                    DispatchQueue.main.async {
                        print("self.profileImageData?.isEmpty \(String(describing: self.profileImageData.isEmpty))")
                        self.profileImageData = data
                        self.delegate?.imageSuccess()
                    }
                  
                }).resume()
            case .failure(let error):
                self.delegate?.imageFailure(error)
            }
        }
    }
    
}
