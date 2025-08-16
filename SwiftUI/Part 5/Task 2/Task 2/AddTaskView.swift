//
//  AddTaskView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var newTask: String = ""
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("Enter new task...", text: $newTask)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                taskManager.addTask(task: newTask)
                newTask = ""
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24))
            }
            .buttonStyle(.borderedProminent)
            .disabled(newTask.isEmpty)
        }
    }
}
