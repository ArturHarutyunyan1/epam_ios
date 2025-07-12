//
//  ViewController.swift
//  UserPreferences
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

extension Notification.Name {
    static let appThemeDidChange = Notification.Name("appThemeDidChange")
}

enum AppTheme: String {
    case light
    case dark
    
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return .black
        case .dark:
            return .white
        }
    }
}

final class ThemeManager {
    static let shared = ThemeManager()
    private let themeKey = "themeKey"
    
    private init() {
        if let saved = UserDefaults.standard.string(forKey: themeKey),
           let theme = AppTheme(rawValue: saved) {
            currentTheme = theme
        } else {
            currentTheme = .light
        }
    }
    
    private(set) var currentTheme: AppTheme {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: themeKey)
            NotificationCenter.default.post(name: .appThemeDidChange, object: nil)
        }
    }
    
    func setTheme(_ theme: AppTheme) {
        guard theme != currentTheme else { return }
        currentTheme = theme
    }
}

extension UIViewController {
    func applyTheme() {
        view.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
    }
    func observeThemeChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleThemeChange), name: .appThemeDidChange, object: nil)
    }
    
    func removeThemeObserver() {
        NotificationCenter.default.removeObserver(self, name: .appThemeDidChange, object: nil)
    }
    
    @objc private func handleThemeChange() {
        applyTheme()
    }
}

class ViewController: UIViewController {
    private let themeSwither = UISwitch()
    private let nextVCButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        observeThemeChange()
        
        themeSwither.translatesAutoresizingMaskIntoConstraints = false
        themeSwither.addTarget(self, action: #selector(toggleTheme), for: .valueChanged)
        view.addSubview(themeSwither)
        
        nextVCButton.translatesAutoresizingMaskIntoConstraints = false
        nextVCButton.setTitle("Next VC", for: .normal)
        nextVCButton.addTarget(self, action: #selector(nextVCButtonTapped), for: .touchUpInside)
        view.addSubview(nextVCButton)
        
        NSLayoutConstraint.activate([
            themeSwither.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themeSwither.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            nextVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextVCButton.topAnchor.constraint(equalTo: themeSwither.bottomAnchor, constant: 20)
        ])
        
        themeSwither.isOn = ThemeManager.shared.currentTheme == .dark
    }
    
    @objc private func toggleTheme() {
        let newTheme: AppTheme = themeSwither.isOn ? .dark : .light
        ThemeManager.shared.setTheme(newTheme)
    }
    
    @objc private func nextVCButtonTapped() {
        let nextVC = SecondViewController()
        present(nextVC, animated: true)
        
    }
    
    deinit {
        removeThemeObserver()
    }
}


class SecondViewController: UIViewController {
    private let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        observeThemeChange()
        textLabel.text = "Second View Controller"
        textLabel.textColor = ThemeManager.shared.currentTheme.textColor
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    deinit {
        removeThemeObserver()
    }
}

#Preview {
    ViewController()
}
