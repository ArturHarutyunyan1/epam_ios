//
//  KeyboardEventsViewController.swift
//  KeyboardEvents
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

class KeyboardEventsViewController: UIViewController {
    private let textField = UITextField()
    private var centerConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        textField.placeholder = "Enter text"
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        centerConstraint = textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        centerConstraint.isActive = true
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            centerConstraint.constant = -keyboardHeight / 2
        }
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        centerConstraint.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

#Preview {
    KeyboardEventsViewController()
}
