//
//  ViewController.swift
//  Task 2
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
            print("Operation \"A\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"A\" finished")
        }
        
        let op2 = BlockOperation {
            print("Operation \"B\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"B\" finished")
        }
        
        let op3 = BlockOperation {
            print("Operation \"C\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"C\" finished")
        }
        
        let op4 = BlockOperation {
            print("Operation \"D\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"D\" finished")
        }
        
        let op5 = BlockOperation {
            print("Operation \"E\" started")
            for _ in 0..<1000000 {
                // do nothing
            }
            print("Operation \"E\" finished")
        }
        op2.addDependency(op3)
        op4.addDependency(op2)
        op1.queuePriority = .low
//        operationQueue.maxConcurrentOperationCount = 6
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.addOperations([op1, op2, op3, op4, op5], waitUntilFinished: false)
    }
}

