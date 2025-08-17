//
//  UiKitView.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 17.08.25.
//

import UIKit

final class UIKitView: UIView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let navigateButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .black
        messageLabel.text = "Hello, from UIKit"
        navigateButton.setTitle("Naivgate to SwiftUI view", for: .normal)
        
        addSubview(messageLabel)
        addSubview(navigateButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            navigateButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            navigateButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
