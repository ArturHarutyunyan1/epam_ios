//
//  TaskListView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        if taskManager.tasks.isEmpty {
            VStack {
                Spacer()
                Text("No tasks yet")
                    .foregroundColor(.gray)
                    .italic()
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 150)
        } else {
            List {
                ForEach(taskManager.tasks.indices, id: \.self) { index in
                    HStack {
                        Text("\(index)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .frame(width: 30, alignment: .leading)
                        
                        Text(taskManager.tasks[index])
                    }
                    .padding(.vertical, 5)
                }
            }
            .listStyle(.insetGrouped)
        }
    }
}
