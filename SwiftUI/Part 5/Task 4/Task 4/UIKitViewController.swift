//
//  UIKitViewController.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 17.08.25.
//

import UIKit
import SwiftUI

final class UIKitViewController: UIViewController {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, from UIKit!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 15
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

struct UIKitView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIKitViewController {
        return UIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIKitViewController, context: Context) {}
}
