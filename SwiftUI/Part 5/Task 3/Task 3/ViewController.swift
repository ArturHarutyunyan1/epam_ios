//
//  ViewController.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 17.08.25.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {
    
    private lazy var contentView = UIKitView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentView()
        setupActions()
    }
    
    private func setupContentView() {
        view = contentView
    }
    
    private func setupActions() {
        contentView.navigateButton.addTarget(self,
                                             action: #selector(navigateToSwiftUI),
                                             for: .touchUpInside)
    }
    
    @objc private func navigateToSwiftUI() {
        let swiftUIViewController = UIHostingController(rootView: SwiftUIView())
        swiftUIViewController.modalPresentationStyle = .fullScreen
        present(swiftUIViewController, animated: true)
    }
}

#Preview {
    ViewController()
}

