//
//  ViewController.swift
//  LoginSystem
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

class LoginScreenViewController: UIViewController {
    private let textField = UITextField()
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        textField.placeholder = "Email"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Log in", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    @objc private func login() {
        guard let email = textField.text, !email.isEmpty else {
            showAlert("Email can't be empty")
            return
        }
        guard email.contains("@") && email.contains(".") else {
            showAlert("Enter valid email")
            return
        }
        UserDefaults.standard.set(email, forKey: "userEmail")
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        print("navigationController is \(String(describing: navigationController))")
        navigationController?.pushViewController(HomeScreenViewController(), animated: true)
    }
}

class HomeScreenViewController: UIViewController {
    private let logoutButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        if let windowScene = view.window?.windowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            let loginVC = LoginScreenViewController()
            let nav = UINavigationController(rootViewController: loginVC)
            sceneDelegate.window?.rootViewController = nav
        }
    }
}

#Preview {
    LoginScreenViewController()
}
