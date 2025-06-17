//
//  TabViewController.swift
//  MultiTabApp
//
//  Created by Artur Harutyunyan on 15.06.25.
//

import UIKit

class TabViewController: UITabBarController {
    let sharedOnboardingData = OnboardingData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBar()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 240/255, alpha: 1)
    }
    
    private func createTabBar() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.onboardingData = sharedOnboardingData
        let onboarding = UINavigationController(rootViewController: onboardingVC)
        
        let profileVC = ProfileViewController()
        profileVC.onboardingData = sharedOnboardingData
        let profile = UINavigationController(rootViewController: profileVC)
        let settings = SettingsViewController()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 1.0, green: 120/255, blue: 0, alpha: 1)
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 12, weight: .semibold)
        ]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(white: 0.7, alpha: 1),
            .font: UIFont.systemFont(ofSize: 12, weight: .regular)
        ]
        
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(white: 0.7, alpha: 1)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        onboarding.tabBarItem = UITabBarItem(
            title: "Onboarding",
            image: UIImage(systemName: "wand.and.sparkles"),
            tag: 1
        )
        profile.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.circle"),
            tag: 2
        )
        settings.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 3
        )
        
        setViewControllers([onboarding, profile, settings], animated: false)
    }
}

#Preview() {
    TabViewController()
}
