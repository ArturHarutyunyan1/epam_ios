//
//  ContentView.swift
//  Task 4
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

@Observable
final class UserProfile {
    var name: String = ""
    var email: String = ""
}

struct ContentView: View {
    @State private var userProfile = UserProfile()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Profile")
                .font(.title)
                .bold()
            
            Text("Name: \(userProfile.name)")
            Text("Email: \(userProfile.email)")
            
            Divider()
            
            EditProfile(userProfile: userProfile)
            
            Spacer()
        }
        .padding()
    }
}

struct EditProfile: View {
    @Bindable var userProfile: UserProfile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Edit Profile")
                .font(.headline)
            
            TextField("Name", text: $userProfile.name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $userProfile.email)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    ContentView()
}
