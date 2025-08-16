//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Task Manager")
                .font(.largeTitle.bold())
                .padding(.top, 10)
            
            TaskListView()
                .frame(maxHeight: 300)
                .background(Color(.systemGray6))
                .cornerRadius(12)
            
            AddTaskView()
            
            RemoveTaskView()
            
            Spacer()
        }
        .padding()
    }
}

