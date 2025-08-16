//
//  RemoveTaskView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct RemoveTaskView: View {
    @EnvironmentObject var taskManager: TaskManager
    @State private var indexToRemove = ""
    @State private var isOn = false
    
    var body: some View {
        Button(role: .destructive) {
            isOn.toggle()
        } label: {
            Label("Delete Task", systemImage: "trash")
        }
        .buttonStyle(.bordered)
        .alert("Delete task", isPresented: $isOn, actions: {
            TextField("Task index", text: $indexToRemove)
                .keyboardType(.numberPad)
            
            Button("Remove", role: .destructive) {
                taskManager.removeTask(at: indexToRemove)
                indexToRemove = ""
            }
            
            Button("Cancel", role: .cancel) { }
        })
    }
}
