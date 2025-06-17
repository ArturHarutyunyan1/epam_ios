//
//  OnboardingViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class OnboardingViewController: UIViewController {
    private let startButton = UIButton()
    var onboardingData: OnboardingData!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStartButtonTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 240/255, alpha: 1)
        
        startButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.cornerRadius = 14
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(navigateTo), for: .touchUpInside)
        
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            startButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func updateStartButtonTitle() {
        let isEmpty = !onboardingData.fullName.isEmpty && !onboardingData.phoneNumber.isEmpty && !onboardingData.preference.isEmpty
        let title = !isEmpty ? "Start" : "Restart"
        startButton.setTitle(title, for: .normal)
        startButton.backgroundColor = !isEmpty ? UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1) : UIColor(red: 52/255, green: 199/255, blue: 89/255, alpha: 1)
    }
    
    @objc private func navigateTo() {
        let personalInfoVC = PersonalInfoViewController()
        personalInfoVC.onboardingData = onboardingData
        
        let navVC = UINavigationController(rootViewController: personalInfoVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
}
