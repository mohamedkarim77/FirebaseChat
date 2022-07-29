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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chats"
        presenter.delegate = self
        presenter.startListeningForChats()
        startSpinner()
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
        return presenter.chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.cellID, for: indexPath) as? ChatsTableViewCell {
            presenter.getUserProfileImage(index: indexPath.row) { url in
                cell.imageurl = url
              
            }
            cell.chatModel = presenter.chats[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ChatsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ChatsViewController: ChatsPresenterProtocol {
    
//    func imageSuccess() {
//        stopSpinner()
//        chatsTableView.reloadData()
//    }
//
//    func imageFailure(_ error: Error) {
//        stopSpinner()
//    }
    
    func chatSuccess() {
        stopSpinner()
        chatsTableView.reloadData()
    }
    
    func chatFailure(_ error: Error) {
        stopSpinner()
    }
    
}

