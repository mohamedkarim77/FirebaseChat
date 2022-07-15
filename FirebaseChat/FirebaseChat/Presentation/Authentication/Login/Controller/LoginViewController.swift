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
      
    private let presenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.delegate = self
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
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter.login(email: email, password: password)
}
}

extension LoginViewController: LoginPresenterProtocol {
    func loginSuccess() {
        
    }
    
    func loginFailure(error: Error) {
        
    }
    
    
}
