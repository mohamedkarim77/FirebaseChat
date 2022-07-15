//
//  ViewController+Extension.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit

extension UIViewController {
    
    func showAuthAlert() {
        let alert = UIAlertController(title: "Error", message: "Please fill all Data", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }

}
