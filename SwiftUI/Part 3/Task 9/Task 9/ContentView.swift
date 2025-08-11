//
//  ContentView.swift
//  Task 9
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI


struct ContentView: View {
    private let fruits: [Fruit] = [
        Fruit(name: "Apple", details: "Apple is round"),
        Fruit(name: "Banana", details: "Banana is yellow"),
        Fruit(name: "Orange", details: "Orange is also round and orange"),
    ]
    var body: some View {
        NavigationStack {
            List {
                ForEach (fruits) { fruit in
                    NavigationLink(fruit.name) {
                        DetailsView(fruit: fruit)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
