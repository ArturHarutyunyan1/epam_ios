//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct Users : Identifiable {
    let id: Int
    let name: String
}

struct ContentView: View {
    private let users: [Users] = [
        Users(id: 1, name: "Ryan Gosling"),
        Users(id: 2, name: "Max Verstappen"),
        Users(id: 3, name: "Kanye West"),
        Users(id: 4, name: "Eminem"),
        Users(id: 5, name: "Spider-Man"),
    ]
    var body: some View {
        List {
            ForEach(users) { user in
                HStack {
                    Text(user.name)
                    Spacer()
                    Button("Tap") {
                        print(user.name)
                    }
                    .buttonStyle(BorderedButtonStyle())
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
