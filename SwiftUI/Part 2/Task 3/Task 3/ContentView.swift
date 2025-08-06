//
//  ContentView.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Spacer()
                VStack (alignment: .leading) {
                    Text("Max Verstappen")
                        .font(.headline)
                    Text("4x F1 world champion")
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
