//
//  ViewController.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 19.07.25.
//

import UIKit

class ViewController: UIViewController {
    private let operationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOperations()
    }
    
    private func startOperations() {
        let op1 = BlockOperation {
            print("Operation \"B\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"B\" finished")
        }
        let op2 = BlockOperation {
            print("Operation \"A\" started")
            op1.cancel()
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished")
        }
        op1.addDependency(op2)
        operationQueue.addOperations([op1, op2], waitUntilFinished: false)
    }
}

