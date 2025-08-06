//
//  ContentView.swift
//  Task 5
//
//  Created by Artur Harutyunyan on 06.08.25.
//

import SwiftUI

struct CardView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
            content
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardView(title: "Card 1") {
                Image(systemName: "star")
                Text("This is the first card")
            }
            
            CardView(title: "Card 2") {
                VStack {
                    Text("Multiple lines")
                    Text("with VStack")
                }
            }
            
            CardView(title: "Card 3") {
                HStack {
                    Image(systemName: "sun.max")
                    Text("With an icon")
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
