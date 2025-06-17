//
//  SettingsViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 16.06.25.
//

import UIKit

class SettingsViewController: UIViewController {
    private let toggleLabel = UILabel()
    private let toggleSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 240/255, alpha: 1)
        
        toggleLabel.text = "Navigation is easy!"
        toggleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        toggleLabel.textAlignment = .left
        
        toggleLabel.translatesAutoresizingMaskIntoConstraints = false
        toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(toggleLabel)
        view.addSubview(toggleSwitch)
        
        NSLayoutConstraint.activate([
            toggleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toggleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            toggleSwitch.centerYAnchor.constraint(equalTo: toggleLabel.centerYAnchor),
            toggleSwitch.leadingAnchor.constraint(equalTo: toggleLabel.trailingAnchor, constant: 12)
        ])
    }
}
