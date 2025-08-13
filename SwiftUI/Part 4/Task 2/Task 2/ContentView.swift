//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text(isOn ? "Hide text" : "Show text")
            }
            if isOn {
                Text("Hello, SwiftUI!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
