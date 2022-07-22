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
        
        guard let email = emailTextField.text ,
              let password = passwordTextField.text ,
                !email.isEmpty ,!password.isEmpty else {
            showAuthAlert(message: "Please Fill All Fields")
            return
        }
        startSpinner()
        presenter.login(email: email, password: password)
        let vc = MainTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

extension LoginViewController: LoginPresenterProtocol {
    func loginSuccess() {
        stopSpinner()
    }
    
    func loginFailure(error: Error) {
        stopSpinner()
    }
    
}
