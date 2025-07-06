//
//  TopRatedViewController.swift
//  TopRatedShows
//
//  Created by Artur Harutyunyan on 06.07.25.
//

import UIKit

class TopRatedViewController: UIViewController {
    private let tableView = UITableView()
    private let apiHandler = ApiHandler()
    private var topShows: [TopShows.Results] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchShows()
    }
    
    private func fetchShows() {
        Task {
            await apiHandler.fetchTopShows()
            if let shows = apiHandler.topShows?.results {
                topShows = shows.map { $0 }
                setupTableView()
            } else {
                displayError()
            }
            print(topShows)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func displayError() {
        let errorLabel = UILabel()
        errorLabel.text = "Failed to load data: \(apiHandler.errorMessage)"
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension TopRatedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell else {
            return UITableViewCell()
        }
        let data = topShows[indexPath.row]
        cell.configure(data)
        return cell
    }
}


#Preview {
    TopRatedViewController()
}
