//
//  SettingsView.swift
//  Task 8
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Button("Go to Profile") {
                path.append(Destination.profile)
            }
        }
        .navigationTitle("Settings")
    }
}
