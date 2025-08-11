//
//  ProfileView.swift
//  Task 8
//
//  Created by Artur Harutyunyan on 11.08.25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath
    var body: some View {
        VStack {
            Button("Go to Home") {
                path = NavigationPath()
            }
        }
        .navigationTitle("Profile")
    }
}
