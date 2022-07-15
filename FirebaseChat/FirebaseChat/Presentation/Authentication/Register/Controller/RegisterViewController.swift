//
//  RegisterViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 14/07/2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
   private var presenter = RegisterPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupUI()
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        presenter.register(email: email, password: password)
    }
    
    func setupUI() {
        title = "Registration"
        firstNameTextField.setupTextField()
        lastNameTextField.setupTextField()
        emailTextField.setupTextField()
        passwordTextField.setupTextField()
        registerButton.setupButton(title: "Register")
        imageView.addCircleCornerRadius()
        imageView.image = UIImage(named: "person")
        let tap = UITapGestureRecognizer(target: self, action: #selector(addImage))
        imageView.addGestureRecognizer(tap)
        
    }
    
    @objc private func addImage(){
        presentPhotoActionSheet()
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate {
    
    func presentCamera() {
        let cameraVC = UIImagePickerController()
        cameraVC.sourceType = .camera
        cameraVC.delegate = self
        cameraVC.allowsEditing = true
        present(cameraVC, animated: true)
    }
    
    func presentPhotoLiberary() {
        let photoliberaryVC = UIImagePickerController()
        photoliberaryVC.sourceType = .photoLibrary
        photoliberaryVC.delegate = self
        photoliberaryVC.allowsEditing = true
        present(photoliberaryVC, animated: true)
    }
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Photo",
                                            message: "How to add your photo",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoLiberary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: { _ in
            self.presentCamera()
        }))
        present(actionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
}

extension RegisterViewController: RegisterPresenterProtocol {
    func registerFailure(error: Error) {
        
    }
    
    func registerSuccess() {
        
    }
    
}
