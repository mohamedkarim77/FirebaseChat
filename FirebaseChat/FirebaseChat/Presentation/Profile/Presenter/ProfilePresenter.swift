//
//  ProfilePresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import FirebaseAuth

protocol ProfilePresenterProtocol: AnyObject {
    func success()
    func failure()
}

class ProfilePresenter {
    
    weak var delegate: ProfilePresenterProtocol?
    let profileImageCellID = "ProfileImageTableViewCell"
    let userDataCellID = "UserDataTableViewCell"
    let logoutCellID = "LogOutTableViewCell"
    var userEmail: String?
    var profileImageUrl: String?
    
    func getUser(){
        guard let  userEmail = FirebaseAuth.Auth.auth().currentUser?.email,
              !userEmail.isEmpty, let profileImageUrl = UserDefaults.standard.string(forKey: "PROFILE_IMAGE_URL") else {
            print(self.userEmail ?? "eeeeeeee")
            delegate?.failure()
            return
        }
        self.profileImageUrl = profileImageUrl
        self.userEmail = userEmail
        print(self.userEmail ?? "sssss")
        delegate?.success()
    }
    
}
