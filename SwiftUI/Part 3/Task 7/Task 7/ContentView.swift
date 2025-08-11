//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack() {
            VStack {
                Text("Welcome")
                    .font(.headline)
                NavigationLink("Navigate", destination: SecondView())
                    .padding()
                    .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
