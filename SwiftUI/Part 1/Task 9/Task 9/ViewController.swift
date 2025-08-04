//
//  ViewController.swift
//  Task 9
//
//  Created by Artur Harutyunyan on 04.08.25.
//

import UIKit
import Combine

enum NetworkError: Error {
    case invalidURL
    case badResponse
}

struct Titles : Codable {
    let id: Int
    let title: String
}

final class NetworkManager {
    func fetchTitles() -> AnyPublisher<[Titles], Error> {
        guard let endpoint = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: endpoint)
            .map(\.data)
            .decode(type: [Titles].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class ViewController: UIViewController {
    private let tableView = UITableView()
    private let networkManager = NetworkManager()
    private var titles: [Titles] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchTitles()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchTitles() {
        networkManager.fetchTitles()
            .sink(receiveCompletion: { completion in
                if case .failure(let failure) = completion {
                    print(failure.localizedDescription)
                }
            }, receiveValue: { [weak self] titles in
                self?.titles = titles
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.titles[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        cell.textLabel?.textColor = .label
        cell.selectionStyle = .none
        return cell
    }
}

#Preview() {
    ViewController()
}
