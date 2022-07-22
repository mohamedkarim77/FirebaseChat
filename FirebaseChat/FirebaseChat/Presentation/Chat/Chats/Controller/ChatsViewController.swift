//
//  ChatsViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 15/07/2022.
//

import UIKit

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var chatsTableView: UITableView!{
        didSet{
            chatsTableView.delegate = self
            chatsTableView.dataSource = self
            chatsTableView.registerCell(presenter.cellID)
        }
    }
    
    private let presenter = ChatsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        navigationItem.rightBarButtonItems = [createAddNavigationBar()]
    }
    
    func createAddNavigationBar() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
        return button
    }
    
    @objc
    func addTapped() {
        let searchVC = SearchViewController()
        //present(searchVC, animated: true, completion: nil)
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}

extension ChatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellID, for: indexPath) as? ChatsTableViewCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversationViewController()
        navigationController?.pushViewController(conversationVC, animated: true)
    }
    
}

