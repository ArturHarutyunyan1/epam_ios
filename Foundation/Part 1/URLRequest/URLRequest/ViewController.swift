//
//  ViewController.swift
//  URLRequest
//
//  Created by Artur Harutyunyan on 06.07.25.
//

import UIKit

struct UserEmail : Codable {
    let email: String
}

final class ApiHandler {
    var userEmails: [UserEmail] = []
    var errorMessage: String = ""
    
    func fetchUserEmail() async {
        guard let endpoint = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let session = URLSession.shared
        
        do {
            let (data, response) = try await session.data(from: endpoint)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            let decodedData = try JSONDecoder().decode([UserEmail].self, from: data)
            self.userEmails = decodedData
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

class ViewController: UIViewController {
    private let mainStack = UIStackView()
    private let handler = ApiHandler()
    private var userEmails: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmails()
    }
    
    private func fetchEmails() {
        Task {
            await handler.fetchUserEmail()
            userEmails = handler.userEmails.map { $0.email }
            displayEmails()
        }
    }
    
    private func displayEmails() {
        view.backgroundColor = .systemBackground
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.distribution = .fillProportionally
        view.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        if !userEmails.isEmpty {
            for email in userEmails {
                let label = UILabel()
                label.text = email
                label.textAlignment = .center
                mainStack.addArrangedSubview(label)
            }
        } else {
            displayError()
        }
    }
    
    private func displayError() {
        let errorLabel = UILabel()
        errorLabel.text = "Failed to load data: \(handler.errorMessage)"
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

#Preview() {
    ViewController()
}
