//
//  SwiftUIView.swift
//  Task 3
//
//  Created by Artur Harutyunyan on 17.08.25.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(spacing: 20) {
            Text("Hello, from SwiftUI!")
                .font(.system(size: 30, weight: .bold))
            Button("Dismiss SwiftUI view") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

