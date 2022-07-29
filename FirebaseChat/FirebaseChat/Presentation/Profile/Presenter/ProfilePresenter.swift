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
    var userName: String?
    var profileImageUrl: String?
    var profileImageData = Data()
 
    public func getUserData(){
         guard let userDefaultsEmail = UserDefaults.standard.value(forKey: "EMAIL") as? String else {
             return
         }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: userDefaultsEmail)
        DatabaseManager.shared.getAllUsers(completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let usersCollection):
                let user: [SearchResult] = usersCollection.filter({
                    guard let email = $0["email"], email == safeEmail else { return false }
                    guard let _ = $0["name"] else { return false }
                    return true
                }).compactMap({
                    guard let email = $0["email"], let name = $0["name"] else { return nil }
                    return SearchResult(name: name, email: email)
                })
                self.userName = user.first?.name
                self.delegate?.userSuccess()
            case .failure(let error):
                print("Failed to get usres: \(error)")
                self.delegate?.userFailure(error)
            }
          }
        )
    }
    
    func getUserProfileImage() {
     
        guard let email = UserDefaults.standard.value(forKey: "EMAIL") as? String else {
            return 
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
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
                        print("profileImageData: \(String(describing: self.profileImageData.isEmpty))")
                        self.userEmail = email
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
