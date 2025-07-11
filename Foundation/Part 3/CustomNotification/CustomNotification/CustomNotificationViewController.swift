//
//  CustomNotificationViewController.swift
//  CustomNotification
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

extension Notification.Name {
    static let customNotification = Notification.Name("customNotification")
}

class CustomNotificationViewController: UIViewController {
    private let navigationButton = UIButton()
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        label.text = "Waiting for update"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        navigationButton.setTitle("Open Second VC", for: .normal)
        navigationButton.backgroundColor = .systemBlue
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        navigationButton.layer.cornerRadius = 10
        navigationButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)

        view.addSubview(label)
        view.addSubview(navigationButton)

        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: navigationButton.topAnchor, constant: -15),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            label.heightAnchor.constraint(equalToConstant: 40),

            navigationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            navigationButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            navigationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            navigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            navigationButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleUpdate(_:)),
                                               name: .customNotification,
                                               object: nil)
    }

    @objc private func presentVC() {
        let secondVC = SecondViewController()
        present(secondVC, animated: true)
    }

    @objc private func handleUpdate(_ notification: Notification) {
        if let text = notification.userInfo?["newValue"] as? String {
            label.text = text
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

class SecondViewController: UIViewController {
    private let notifyButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        notifyButton.setTitle("Send Notification", for: .normal)
        notifyButton.backgroundColor = .systemGray
        notifyButton.translatesAutoresizingMaskIntoConstraints = false
        notifyButton.layer.cornerRadius = 10
        notifyButton.addTarget(self, action: #selector(postNotification), for: .touchUpInside)

        view.addSubview(notifyButton)

        NSLayoutConstraint.activate([
            notifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notifyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            notifyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            notifyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            notifyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc private func postNotification() {
        NotificationCenter.default.post(name: .customNotification,
                                        object: nil,
                                        userInfo: ["newValue": "Data from Second VC"])
        dismiss(animated: true)
    }
}


#Preview {
    CustomNotificationViewController()
}
