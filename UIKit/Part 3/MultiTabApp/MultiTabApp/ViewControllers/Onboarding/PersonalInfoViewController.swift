//
//  PersonalInfoViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class PersonalInfoViewController: UIViewController {
    var onboardingData: OnboardingData!
    var onCompletion: ((OnboardingData) -> Void)?
    
    private let pageTitle = UILabel()
    private let fullName = UITextField()
    private let phoneNumber = UITextField()
    private let confirmationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 255/255, alpha: 1)
        
        pageTitle.text = "Personal Information"
        pageTitle.textColor = UIColor(red: 40/255, green: 40/255, blue: 50/255, alpha: 1)
        pageTitle.textAlignment = .center
        pageTitle.font = .systemFont(ofSize: 30, weight: .bold)
        
        fullName.placeholder = "Full Name"
        phoneNumber.placeholder = "Phone Number"
        [fullName, phoneNumber].forEach {
            $0.backgroundColor = .white
            $0.borderStyle = .roundedRect
            $0.layer.cornerRadius = 8
            $0.layer.borderColor = UIColor.lightGray.cgColor
            $0.layer.borderWidth = 0.5
            $0.font = .systemFont(ofSize: 16)
            $0.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        }
        phoneNumber.keyboardType = .phonePad
        
        confirmationButton.setTitle("Confirm", for: .normal)
        confirmationButton.setTitleColor(.white, for: .normal)
        confirmationButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        confirmationButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        confirmationButton.layer.cornerRadius = 10
        confirmationButton.isEnabled = false
        confirmationButton.alpha = 0.5
        confirmationButton.addTarget(self, action: #selector(confirmInfo), for: .touchUpInside)
        
        [pageTitle, fullName, phoneNumber, confirmationButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            pageTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            fullName.topAnchor.constraint(equalTo: pageTitle.bottomAnchor, constant: 40),
            fullName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            fullName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            fullName.heightAnchor.constraint(equalToConstant: 48),
            
            phoneNumber.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 16),
            phoneNumber.leadingAnchor.constraint(equalTo: fullName.leadingAnchor),
            phoneNumber.trailingAnchor.constraint(equalTo: fullName.trailingAnchor),
            phoneNumber.heightAnchor.constraint(equalToConstant: 48),
            
            confirmationButton.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 24),
            confirmationButton.leadingAnchor.constraint(equalTo: fullName.leadingAnchor),
            confirmationButton.trailingAnchor.constraint(equalTo: fullName.trailingAnchor),
            confirmationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func textFieldsChanged() {
        guard let name = fullName.text, let phone = phoneNumber.text else { return }
        let isValid = !name.isEmpty && phone.count >= 9
        confirmationButton.isEnabled = isValid
        confirmationButton.alpha = isValid ? 1.0 : 0.5
    }
    
    @objc private func confirmInfo() {
        guard let name = fullName.text, let phone = phoneNumber.text else { return }
        
        let message = "Please confirm your name and phone number.\n\nName: \(name)\nPhone: \(phone)."
        let alert = UIAlertController(title: "Confirm Information", message: message, preferredStyle: .alert)
        let edit = UIAlertAction(title: "Edit", style: .cancel)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            self.onboardingData.fullName = name
            self.onboardingData.phoneNumber = phone
            
            if let onCompletion = self.onCompletion {
                onCompletion(self.onboardingData)
                self.navigationController?.popViewController(animated: true)
            } else {
                let nextVC = PreferencesViewController()
                nextVC.onboardingData = self.onboardingData
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
        alert.addAction(confirmAction)
        alert.addAction(edit)
        present(alert, animated: true)
    }
}
