//
//  StorageManager.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 18/07/2022.
//

import Foundation
import FirebaseStorage

final class StorageManager{
    
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    public typealias uploadImageCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfileImage(data: Data, fileName: String, completion: @escaping uploadImageCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil) { metaData, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
           
            self.storage.child("images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }
    }
    
}
