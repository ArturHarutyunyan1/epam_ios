//
//  ContentView.swift
//  Task 7
//
//  Created by Artur Harutyunyan on 13.08.25.
//
import Observation
import SwiftUI

@Observable
final class Counter {
    var count: Int = 0
}


struct ContentView: View {
    @State private var counter = Counter()
    var body: some View {
        VStack {
            FirstView(counter: counter)
            SecondView(counter: counter)
        }
        .padding()
    }
}

struct FirstView: View {
    @Bindable var counter: Counter
    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            Button("Increment") {
                counter.count += 1
            }
        }
    }
}

struct SecondView: View {
    @Bindable var counter: Counter
    var body: some View {
        VStack {
            Text("Count: \(counter.count)")
            Button("Increment") {
                counter.count += 1
            }
        }
    }
}

#Preview {
    ContentView()
}
