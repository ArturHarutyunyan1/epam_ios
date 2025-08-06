//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn: Bool = false
    var body: some View {
        VStack {
            Toggle(isOn: $isOn) {
                Text("Show Greeting")
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
