//
//  ViewController.swift
//  RecentSearches
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    private var recentSearches = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(searchBar)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        displayRecentSearches()
    }
    
    private func displayRecentSearches() {
        if let array = UserDefaults.standard.stringArray(forKey: "recentSearches") {
            recentSearches = array
            tableView.reloadData()
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = recentSearches[indexPath.row]
        return cell
    }
    
    
}

extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            recentSearches = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
            recentSearches.append(text)
            if recentSearches.count > 5 {
                recentSearches.removeFirst(recentSearches.count - 5)
            }
            UserDefaults.standard.set(recentSearches, forKey: "recentSearches")
            searchBar.text = ""
            searchBar.resignFirstResponder()
            displayRecentSearches()
        }
    }
}


#Preview {
    ViewController()
}
