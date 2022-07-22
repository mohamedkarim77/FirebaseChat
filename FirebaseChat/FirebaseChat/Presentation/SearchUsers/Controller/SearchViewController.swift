//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 20/07/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTableView: UITableView!{
        didSet{
            searchTableView.delegate = self
            searchTableView.dataSource = self
            searchTableView.registerCell(presenter.searchCellID)
        }
    }
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let presenter = SearchPresenter()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        
        searchController.hidesNavigationBarDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self as? UISearchBarDelegate

        let frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        let titleView = UIView(frame: frame)
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.frame = frame
        titleView.addSubview(searchController.searchBar)
        navigationItem.titleView = titleView
        }
    }


extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.searchCellID, for: indexPath) as? SearchTableViewCell  {
            cell.searchLabel.text = "usiduiudfsdfs"
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchViewController: SearchPresenterProtocol {
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         
    }
}
