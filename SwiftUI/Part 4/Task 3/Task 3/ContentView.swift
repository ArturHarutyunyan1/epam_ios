//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isOn = false
    var body: some View {
        VStack {
            ToggleView(isOn: $isOn)
            Text("Toggle is \(isOn ? "On" : "Off")")
        }
        .padding()
    }
}

struct ToggleView: View {
    @Binding var isOn: Bool
    var body: some View {
        Toggle(isOn: $isOn) {
            
        }
    }
}

#Preview {
    ContentView()
}
