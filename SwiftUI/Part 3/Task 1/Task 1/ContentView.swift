//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("SwiftUI Layout Modifiers")
                .padding(16)
                .padding(.vertical, 18)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 90)
                .background(.red)
        }
    }
}

#Preview {
    ContentView()
}
