//
//  ContentView.swift
//  Task 10
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Text("Home")
            }
            .navigationTitle("My app")
            .toolbarBackground(.gray, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Settings") {
                        path.append(Destination.settings)
                    }
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                    )
                    .foregroundColor(.white)
                    .buttonStyle(.plain)
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .settings:
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
