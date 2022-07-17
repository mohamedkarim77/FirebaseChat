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

