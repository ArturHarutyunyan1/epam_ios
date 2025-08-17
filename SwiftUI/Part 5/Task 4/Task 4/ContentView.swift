//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 17.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
                .font(.title2)
                .fontWeight(.medium)
            UIKitView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
