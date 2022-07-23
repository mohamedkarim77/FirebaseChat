//
//  SearchPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 20/07/2022.
//

import Foundation
import SwiftUI

protocol SearchPresenterProtocol: AnyObject {
    func searchSuccess()
    func searchFailure(error: Error)
}

class SearchPresenter {
    
    weak var delegate: SearchPresenterProtocol?
    let searchCellID = "SearchTableViewCell"
    var hasFetched: Bool = false
    var users = [[String: String]]()
    var searchResults = [SearchResult]()
    
    func searchUsers(query: String){
        if hasFetched {
            filterUsers(with: query)
            delegate?.searchSuccess()
        } else {
            DatabaseManager.shared.getAllUsers(completion: { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let usersCollection):
                    self.hasFetched = true
                    self.users = usersCollection
                    self.filterUsers(with: query)
                    self.delegate?.searchSuccess()
                case .failure(let error):
                    print("Failed to get usres: \(error)")
                    self.delegate?.searchFailure(error: error)
                }
              }
            )
        }
    }
    
    func filterUsers(with term: String){
        guard let currentUserEmail = UserDefaults.standard.value(forKey: "EMAIL") as? String, hasFetched else {
            return
        }
        let safeEmail = DatabaseManager.safeEmail(emailAddress: currentUserEmail)
        let results: [SearchResult] = users.filter({
            guard let email = $0["email"], email != safeEmail else { return false }
            guard let name = $0["name"]?.lowercased() else { return false }
            return name.hasPrefix(term.lowercased())
        }).compactMap({
            guard let email = $0["email"], let name = $0["name"] else { return nil }
            return SearchResult(name: name, email: email)
        })
        
        searchResults = results
        print(searchResults.first?.name ?? "")
    }
    
    
    
}
