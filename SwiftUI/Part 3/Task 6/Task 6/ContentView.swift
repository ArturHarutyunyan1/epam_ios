//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct CustomButton: ViewModifier {
    var isEnabled: Bool = true
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(10)
            .background(isEnabled ? .blue : .gray)
            .foregroundStyle(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .contentShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .disabled(!isEnabled)
    }
}

extension View {
    func customButtonStyle(isEnabled: Bool) -> some View {
        self.modifier(CustomButton(isEnabled: isEnabled))
    }
}

struct ContentView: View {
    @State private var isEnabled: Bool = true
    var body: some View {
        VStack {
            Button("Hello") {}
                .customButtonStyle(isEnabled: isEnabled)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
