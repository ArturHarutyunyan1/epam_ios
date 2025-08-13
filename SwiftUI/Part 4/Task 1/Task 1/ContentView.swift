//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0
    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("+1") {
                count += 1
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
