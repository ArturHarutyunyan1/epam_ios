//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(.blue)
                .frame(width: 100)
                .offset(x: -170, y: -390)
            Rectangle()
                .foregroundStyle(.red)
                .frame(width: 100, height: 100)
                .offset(x: -190, y: -300)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
