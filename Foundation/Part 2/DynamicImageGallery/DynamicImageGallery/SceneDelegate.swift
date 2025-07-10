//
//  SceneDelegate.swift
//  DynamicImageGallery
//
//  Created by Artur Harutyunyan on 10.07.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = DynamicImageGalleryViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}

