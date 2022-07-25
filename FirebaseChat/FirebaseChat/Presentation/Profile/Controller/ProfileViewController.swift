//
//  ProfileViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView! {
        didSet {
            userTableView.delegate = self
            userTableView.dataSource = self
            userTableView.registerCells(
                [presenter.userDataCellID, presenter.logoutCellID, presenter.profileImageCellID])
        }
    }
    
    private var presenter = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        startSpinner()
        presenter.getUserProfileImage()
        presenter.getUserData()
        title = "Profile"
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let width = tableView.layer.frame.width
            return width * 0.8
        case 1,2,3:
            return 80
        default:
           return 80
        }
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.profileImageCellID, for: indexPath) as? ProfileImageTableViewCell {
                 let image = UIImage(data: presenter.profileImageData)
                cell.profileImageView.image = image
                return cell
            }
            return UITableViewCell()
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.userDataCellID, for: indexPath) as? UserDataTableViewCell {
                cell.userDataLabel.text = "Name : \(presenter.userName ?? "")"
                return cell
            }
            return UITableViewCell()
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.userDataCellID, for: indexPath) as? UserDataTableViewCell {
                cell.userDataLabel.text = "Email : \(presenter.userEmail ?? "")"
                return cell
            }
            return UITableViewCell()
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.logoutCellID, for: indexPath) as? LogOutTableViewCell {
                cell.logout = {
                    self.goToLogin()
                }
                return cell
            }
            return UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
    func goToLogin() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let ok = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                UserDefaults.standard.setValue("", forKey: "EMAIL")
                let scene = self?.view.window?.windowScene?.delegate as? SceneDelegate
                let loginVC = LoginViewController()
                let navigation = UINavigationController(rootViewController: loginVC)
                scene?.window?.rootViewController = navigation
            } catch  {
                print("Failed to log out")
            }
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}

extension ProfileViewController: ProfilePresenterProtocol {
    func userSuccess() {
        stopSpinner()
        userTableView.reloadData()
    }
    
    func userFailure(_ error: Error) {
        stopSpinner()
    }
    
    func imageSuccess() {
        stopSpinner()
        userTableView.reloadData()
    }
    
    func imageFailure(_ error: Error) {
        stopSpinner()
    }
    
}

