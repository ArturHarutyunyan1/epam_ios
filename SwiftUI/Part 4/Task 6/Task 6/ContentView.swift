//
//  ContentView.swift
//  Task 6
//
//  Created by Artur Harutyunyan on 13.08.25.
//

import SwiftUI

struct Setting: Identifiable {
    let id = UUID()
    var name: String
    var isOn: Bool
}

struct ContentView: View {
    @State private var settings: [Setting] = [
        Setting(name: "Setting 1", isOn: false),
        Setting(name: "Setting 2", isOn: true),
        Setting(name: "Setting 3", isOn: false),
        Setting(name: "Setting 4", isOn: true)
    ]
    var body: some View {
        List {
            ForEach($settings) { $setting in
                Toggle("\(setting.name)", isOn: $setting.isOn)
            }
        }
    }
}

#Preview {
    ContentView()
}
