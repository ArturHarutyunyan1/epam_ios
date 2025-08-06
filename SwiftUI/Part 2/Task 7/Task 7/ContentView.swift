//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct User {
    let name: String
    let age: Int
    let location: String
    let isPremium: Bool
}

struct ContentView: View {
    private var user: User = User(name: "Max Verstappen", age: 27, location: "Netherlands", isPremium: true)
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.gray)
                        .frame(width: 100, height: 100)
                    if user.isPremium {
                        Text("Premium")
                            .font(.caption)
                            .padding(10)
                            .background(.yellow)
                            .clipShape(Capsule())
                            .offset(x: 30, y: -30)
                    }
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text("\(user.age) years old")
                        .font(.subheadline)
                    Text(user.location)
                        .font(.subheadline)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
