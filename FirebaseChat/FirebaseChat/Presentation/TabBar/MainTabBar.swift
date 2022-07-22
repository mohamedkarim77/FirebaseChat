//
//  MainTabBar.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        let chat = ChatsViewController()
        chat.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message"), tag: 0)
        let chatNavigation = UINavigationController(rootViewController: chat)
        
        let profile = ProfileViewController()
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        let profileNavigation = UINavigationController(rootViewController: profile)
        viewControllers = [chatNavigation, profileNavigation]
    }
}
