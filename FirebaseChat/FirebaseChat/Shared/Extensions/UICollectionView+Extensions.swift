//
//  UICollectionView+Extensions.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import UIKit

extension UICollectionView {
    
    func registerCells(_ ids: [String]) {
        for id in ids {
            registerCell(id)
        }
    }
    
    func registerCell(_ id: String) {
        self.register(UINib(nibName: id, bundle: nil), forCellWithReuseIdentifier: id)
    }
    
    func registerHeaderFooter(_ id: String, type: String) {
        self.register(UINib(nibName: id, bundle: nil), forSupplementaryViewOfKind: type, withReuseIdentifier: id)
    }
    
}
