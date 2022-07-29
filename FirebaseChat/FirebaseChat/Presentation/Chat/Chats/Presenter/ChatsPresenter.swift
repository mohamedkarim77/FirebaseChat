//
//  ChatsPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import UIKit

protocol ChatsPresenterProtocol: AnyObject {
    func chatSuccess()
    func chatFailure(_ error: Error)
//    func imageSuccess()
//    func imageFailure(_ error: Error)
}

class ChatsPresenter {
    
    weak var delegate: ChatsPresenterProtocol?
    let cellID = "ChatsTableViewCell"
    var chats = [Chat]()
    
    func startListeningForChats(){
        guard let email = UserDefaults.standard.string(forKey: "EMAIL") else {return}
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        DatabaseManager.shared.getAllChats(for: safeEmail) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let chats):
                self.chats = chats
                DispatchQueue.main.async {
                    self.delegate?.chatSuccess()
                }
            case .failure(let error):
                self.delegate?.chatFailure(error)
                print(error)
            }
        }
    }
    
    func getUserProfileImage(index: Int, completion: @escaping (URL?) -> ())  {
        
        let storageManager = StorageManager.shared
        let path = "images/\(chats[index].otherUserEmail)_profile_image.png"
        
        print(path)
        storageManager.downloadURL(for: path) { result in
            switch result {
            case .success(let url):
                print("image url \(url)")
                //DispatchQueue.main.async{
                    completion(url)
                //}
            case .failure(let error):
               // self.delegate?.imageFailure(error)
                print(error)
            }
            
        }
    }
    
}
