//
//  ViewController.swift
//  FirebaseChat
//
//  Created by Mohamed Abdelkarim on 20/07/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var noResultLabel: UILabel!{
        didSet{
            noResultLabel.isHidden = true
            noResultLabel.text = "No Results"
        }
    }
    @IBOutlet weak var searchTableView: UITableView!{
        didSet{
            searchTableView.isHidden = true
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
        searchController.searchBar.delegate = self
        
        let frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        let titleView = UIView(frame: frame)
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.frame = frame
        titleView.addSubview(searchController.searchBar)
        navigationItem.titleView = titleView
        
        self.definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
    }
}


extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: presenter.searchCellID, for: indexPath) as? SearchTableViewCell  {
            cell.searchLabel.text = presenter.searchResults[indexPath.row].name
            print(presenter.searchResults[indexPath.row].name)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SearchViewController: SearchPresenterProtocol {
    func searchSuccess() {
        stopSpinner()
        self.noResultLabel.isHidden = true
        searchTableView.isHidden = false
        searchTableView.reloadData()
    }
    
    func searchFailure(error: Error) {
        stopSpinner()
        noResultLabel.isHidden = false
        searchTableView.isHidden = true
        
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else { return }
        searchBar.resignFirstResponder()
        presenter.searchResults.removeAll()
        startSpinner()
        presenter.searchUsers(query: text)
        
    }
}
