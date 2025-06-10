//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    private let view1 = UIView()
    private let view2 = UIView()
    
    private var horizontalConstraint: [NSLayoutConstraint] = []
    private var verticalConstraint: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.backgroundColor = .systemBlue
        view2.backgroundColor = .systemMint
        
        [view1, view2].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(view1)
        view.addSubview(view2)
        registerForTraitChanges()
        setupConstraints()
        activateConstraints()
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
            self.activateConstraints()
        }
    }
    
    private func setupConstraints() {
        horizontalConstraint = [
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view1.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -16),
            view1.heightAnchor.constraint(equalToConstant: 200),
            
            view2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 16),
            view2.widthAnchor.constraint(equalTo: view1.widthAnchor),
            view2.heightAnchor.constraint(equalToConstant: 200)
        ]
        
        verticalConstraint = [
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            view1.heightAnchor.constraint(equalToConstant: 200),
            
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 12),
            view2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            view2.heightAnchor.constraint(equalToConstant: 200),
        ]
    }
    
    private func activateConstraints() {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.deactivate(horizontalConstraint)
            NSLayoutConstraint.activate(self.verticalConstraint)
        } else {
            NSLayoutConstraint.deactivate(verticalConstraint)
            NSLayoutConstraint.activate(self.horizontalConstraint)
        }
    }
}

#Preview {
    Task4ViewController()
}
