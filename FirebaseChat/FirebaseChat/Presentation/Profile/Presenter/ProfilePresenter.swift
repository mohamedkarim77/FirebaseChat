//
//  ProfilePresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation

protocol ProfilePresenterProtocol: AnyObject {
    
}

class ProfilePresenter {
    
    weak var delegate: ProfilePresenterProtocol?
    let profileImageCellID = "ProfileImageTableViewCell"
    let userDataCellID = "UserDataTableViewCell"
    let logoutCellID = "LogOutTableViewCell"
   
}
