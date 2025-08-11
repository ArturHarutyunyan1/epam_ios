//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI is amazing!")
                .background(
                    Rectangle()
                        .foregroundStyle(.gray)
                )
                .overlay(
                    Circle()
                        .opacity(0.3)
                )
                .clipShape(
                    Circle()
                )
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
