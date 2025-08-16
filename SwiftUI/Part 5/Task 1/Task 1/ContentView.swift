//
//  ContentView.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CounterDisplayView()
            HStack {
                IncrementCounterView()
                DecrementCounterView()
            }
        }
        .padding()
    }
}



#Preview {
    @StateObject var counter = Counter()
    ContentView()
        .environmentObject(counter)
}
