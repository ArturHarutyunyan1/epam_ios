//
//  TaskManager.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import Foundation

final class TaskManager: ObservableObject {
    @Published var tasks: [String] = []
    
    func addTask(task: String) {
        if !task.isEmpty {
            tasks.append(task)
        }
    }
    
    func removeTask(at index: String) {
        if let index = Int(index), index >= 0 && index < tasks.count {
            tasks.remove(at: index)
        }
    }
}
