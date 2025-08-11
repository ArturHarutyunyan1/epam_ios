//
//  ContentView.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Rectangle()
                .fill(Color.red)
                .frame(width: 150, height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            Rectangle()
                .fill(Color.blue)
                .frame(width: 150, height: 100)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
