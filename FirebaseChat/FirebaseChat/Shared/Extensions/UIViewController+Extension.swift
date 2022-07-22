//
//  ViewController+Extension.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit
import ARSLineProgress
extension UIViewController {
    
    
    
    func showAuthAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func startSpinner() {
        ARSLineProgress.show()
    }
    
    func stopSpinner() {
        ARSLineProgress.hide()
    }

}
