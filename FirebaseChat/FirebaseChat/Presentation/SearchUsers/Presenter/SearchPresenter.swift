//
//  SearchPresenter.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 20/07/2022.
//

import Foundation

protocol SearchPresenterProtocol: AnyObject {
    
}

class SearchPresenter {
    weak var delegate: SearchPresenterProtocol?
    let searchCellID = "SearchTableViewCell"
}
