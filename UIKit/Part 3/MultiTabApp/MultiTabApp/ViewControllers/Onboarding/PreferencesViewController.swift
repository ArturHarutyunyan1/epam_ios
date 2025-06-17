//
//  PreferencesViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class PreferencesViewController: UIViewController {
    var onboardingData: OnboardingData!
    private let alertButton = UIButton()
    private let selectedPreference = UILabel()
    private let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 255/255, alpha: 1)
        
        
        alertButton.setTitle("Select Notification Preference", for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        alertButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        alertButton.layer.cornerRadius = 10
        alertButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        selectedPreference.textColor = UIColor(red: 50/255, green: 50/255, blue: 60/255, alpha: 1)
        selectedPreference.textAlignment = .center
        selectedPreference.numberOfLines = 0
        selectedPreference.font = .systemFont(ofSize: 16, weight: .medium)
        
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        nextButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        nextButton.layer.cornerRadius = 10
        nextButton.isEnabled = false
        nextButton.alpha = 0.5
        nextButton.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        
        [alertButton, selectedPreference, nextButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            alertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            
            selectedPreference.topAnchor.constraint(equalTo: alertButton.bottomAnchor, constant: 20),
            selectedPreference.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            selectedPreference.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            nextButton.topAnchor.constraint(equalTo: selectedPreference.bottomAnchor, constant: 24),
            nextButton.leadingAnchor.constraint(equalTo: alertButton.leadingAnchor),
            nextButton.trailingAnchor.constraint(equalTo: alertButton.trailingAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(title: "Select Notification Preference", message: nil, preferredStyle: .actionSheet)
        
        let preferences = [
            "Email Notifications",
            "SMS Notifications",
            "Push Notifications"
        ]
        
        preferences.forEach { option in
            alert.addAction(UIAlertAction(title: option, style: .default) { _ in
                self.selectedPreference.text = "Chosen notification type - \(option)"
                self.onboardingData.preference = option
                self.nextButton.isEnabled = true
                self.nextButton.alpha = 1.0
            })
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc private func nextView() {
        let nextVC = ConfirmDetailsViewController()
        nextVC.onboardingData = onboardingData
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
