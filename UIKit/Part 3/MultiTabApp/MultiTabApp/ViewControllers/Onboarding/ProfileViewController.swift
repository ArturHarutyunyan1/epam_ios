//
//  ProfileViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class ProfileViewController : UIViewController {
    var onboardingData: OnboardingData!
    private let nameLabel = UILabel()
    private let editButton = UIButton()
    private var name: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController - ViewDidAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileViewController - ViewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileViewController - ViewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileViewController - ViewWillDissapear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileViewController - ViewDidDissapear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        name = onboardingData.fullName.isEmpty ? "Default" : onboardingData.fullName
        nameLabel.text = "Name: " + name
        nameLabel.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 240/255, alpha: 1)
        
        editButton.setTitle("Edit Profile", for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        editButton.setTitleColor(.white, for: .normal)
        editButton.layer.cornerRadius = 14
        editButton.backgroundColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        
        let pencilButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(editName)
        )
        let anonButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(setName)
        )
        navigationItem.rightBarButtonItems = [anonButton, pencilButton]
        
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.7
        nameLabel.numberOfLines = 0
        
        [nameLabel, editButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            editButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            editButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func setName() {
        updateName("Anonymous")
    }
    
    @objc private func editName() {
        let alert = UIAlertController(title: "Enter Name", message: "Please enter your name", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Full Name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            if let name = alert.textFields?.first?.text, !name.isEmpty {
                self.updateName(name)
            } else {
                self.updateName("Default")
            }
        }))
        
        present(alert, animated: true)
    }
    
    @objc private func editProfile() {
        let nextVC = EditProfileViewController()
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func updateName(_ name: String) {
        self.onboardingData.fullName = name
        
        DispatchQueue.main.async {
            self.nameLabel.text = "Name: " + name
        }
    }
}
