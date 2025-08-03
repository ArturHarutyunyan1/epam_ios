//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Harutyunyan on 03.08.25.
//

import SwiftUI
import Combine

struct ContentView: View {
    private let publisher = PassthroughSubject<Int, Never>()
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Button("Click me") {
                publisher.send(counter + 1)
            }
            Text("Click count is \(counter)")
        }
        .padding()
        .onReceive(publisher) { value in
            self.counter = value
        }
    }
}

#Preview {
    ContentView()
}
