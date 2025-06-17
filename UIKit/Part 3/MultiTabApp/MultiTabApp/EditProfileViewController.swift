//
//  EditProfileViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit


class EditProfileViewController : UIViewController {
    private let infoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EditProfileViewController - ViewDidLoad")
        
        view.backgroundColor = .white
        navigationItem.title = "Edit Profile"
        infoLabel.text = "Editing..."
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        infoLabel.textColor = .black
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfileViewController - ViewWillAppear")
        infoLabel.textColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfileViewController - ViewDidAppear")
        view.backgroundColor = UIColor.systemYellow
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfileViewController - ViewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfileViewController - ViewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfileViewController - ViewWillDisappear")
        infoLabel.text = "Leaving..."
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfileViewController - viewDidDisappear")
    }
    
}
