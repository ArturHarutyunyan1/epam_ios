//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .bottom, spacing: 50) {
            Text("Item 1")
                .font(.title)
            Text("Item 2")
                .font(.body)
            Text("Item 3")
                .font(.caption)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
