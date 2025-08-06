//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct TodoList : Identifiable {
    let id: Int
    let todo: String
    var isCompleted: Bool
}


struct ContentView: View {
    @State private var todos: [TodoList] = [
        TodoList(id: 1, todo: "Tu tu tu tu MAX VERSTAPPEN", isCompleted: false),
        TodoList(id: 2, todo: "Swing through the city like Spider-Man", isCompleted: true),
        TodoList(id: 3, todo: "Save the city from the Green Goblin", isCompleted: false),
        
        ]
    var body: some View {
        List {
            ForEach($todos) { $todo in
                HStack {
                    Text(todo.todo)
                    Spacer()
                    Toggle("", isOn: $todo.isCompleted)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
