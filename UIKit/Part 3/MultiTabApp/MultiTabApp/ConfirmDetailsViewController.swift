//
//  ConfirmDetailsViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {
    var onboardingData: OnboardingData!
    
    private let name = UILabel()
    private let phone = UILabel()
    private let preference = UILabel()
    
    private let startOver = UIButton()
    private let preferenceButton = UIButton()
    private let personalInfo = UIButton()
    private let confirm = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 245/255, green: 248/255, blue: 255/255, alpha: 1)
        navigationItem.hidesBackButton = true
        
        setupScrollViewAndStack()
        configureLabels()
        configureButtons()
    }
    
    private func setupScrollViewAndStack() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentStack.axis = .vertical
        contentStack.spacing = 16
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -20),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func configureLabels() {
        [name, phone, preference].forEach {
            $0.font = .systemFont(ofSize: 18, weight: .semibold)
            $0.textColor = UIColor(red: 40/255, green: 40/255, blue: 50/255, alpha: 1)
            $0.numberOfLines = 0
            contentStack.addArrangedSubview($0)
        }
        
        name.text = "Name: \(onboardingData.fullName)"
        phone.text = "Phone Number: \(onboardingData.phoneNumber)"
        preference.text = "Notification Preference: \(onboardingData.preference)"
    }
    
    private func configureButtons() {
        func styleButton(_ button: UIButton, title: String, action: Selector) {
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            button.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
            button.layer.cornerRadius = 10
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: action, for: .touchUpInside)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            contentStack.addArrangedSubview(button)
        }
        
        styleButton(startOver, title: "Start Over", action: #selector(restartOnboarding))
        styleButton(preferenceButton, title: "Edit Preferences", action: #selector(editPreferences))
        styleButton(personalInfo, title: "Edit Personal Info", action: #selector(editPersonalInfo))
        styleButton(confirm, title: "Confirm", action: #selector(confirmAll))
    }
    
    @objc private func restartOnboarding() {
        onboardingData.preference = ""
        onboardingData.fullName = ""
        onboardingData.phoneNumber = ""
        self.dismiss(animated: true)
    }
    
    @objc private func editPreferences() {
        onboardingData.preference = ""
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editPersonalInfo() {
        let personalInfoVC = PersonalInfoViewController()
        personalInfoVC.onboardingData = onboardingData
        
        personalInfoVC.onCompletion = { [weak self] updatedData in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.onboardingData = updatedData
                self.name.text = "Name: \(updatedData.fullName)"
                self.phone.text = "Phone Number: \(updatedData.phoneNumber)"
            }
        }
        navigationController?.pushViewController(personalInfoVC, animated: true)
    }
    
    @objc private func confirmAll() {
        let message = "You have successfully passed the onboarding"
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
