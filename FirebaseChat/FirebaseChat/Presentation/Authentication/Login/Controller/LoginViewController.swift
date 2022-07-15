//
//  LoginViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        title = " Login"
        navigationItem.rightBarButtonItem = createNavigationBar()
        emailTextField.setupTextField()
        passwordTextField.setupTextField()
        loginButton.setupButton(title: "Login")
        imageView.image = UIImage(named: "logo")
        
    }
    
    func createNavigationBar() -> UIBarButtonItem {
        let button = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerTapped))
        return button
    }
    
    @objc private func registerTapped() {
        let RegisterVC = RegisterViewController()
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] authResult, error in
            guard let self = self else { return }
            guard let result = authResult, error == nil else {
                print("Failed to login: \(error)")
                return}
            let user = result.user
            print("Succeful login: \(user)")
        }
    }
}
