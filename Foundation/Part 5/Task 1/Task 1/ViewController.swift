//
//  ViewController.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 18.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runOperations()
    }
    
    private func runOperations() {
        operationQueue.addOperation {
            print("Operation \"A\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished")
        }
        
        OperationQueue.main.addOperation {
            print("Operation \"A\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished")
        }
    }
}


#Preview {
    ViewController()
}
