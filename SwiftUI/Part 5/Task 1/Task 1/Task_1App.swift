//
//  Task_1App.swift
//  Task 1
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

@main
struct Task_1App: App {
    @StateObject var counter = Counter()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(counter)
        }
    }
}
