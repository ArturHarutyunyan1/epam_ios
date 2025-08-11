//
//  ContentView.swift
//  Task 8
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct HomeView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button("Go to Settings") {
                    path.append(Destination.settings)
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .home:
                    EmptyView()
                case .settings:
                    SettingsView(path: $path)
                case .profile:
                    ProfileView(path: $path)
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
