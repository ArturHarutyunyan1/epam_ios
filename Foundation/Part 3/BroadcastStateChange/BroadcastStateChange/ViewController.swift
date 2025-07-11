//
//  ViewController.swift
//  BroadcastStateChange
//
//  Created by Artur Harutyunyan on 12.07.25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func didEnterBackground(_ notification: Notification) {
        print("App has entered background")
    }
    
    @objc private func willEnterForeground(_ notification: Notification) {
        print("App is about to enter foreground")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}
