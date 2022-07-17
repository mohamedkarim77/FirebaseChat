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
    
    let presenter = ProfilePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        title = "Profile"
    }

}

extension ProfileViewController: ProfilePresenterProtocol {
    
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
                
                return cell
            }
            return UITableViewCell()
        case 1,2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.userDataCellID, for: indexPath) as? UserDataTableViewCell {
                
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
                let scene = self?.view.window?.windowScene?.delegate as? SceneDelegate
                scene?.window?.rootViewController = LoginViewController()
            } catch  {
                print("Failed to log out")
            }
          
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}
