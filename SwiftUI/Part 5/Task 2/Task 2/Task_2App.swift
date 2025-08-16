//
//  Task_2App.swift
//  Task 2
//
//  Created by Artur Harutyunyan on 16.08.25.
//

import SwiftUI

@main
struct Task_2App: App {
    @StateObject private var taskManager = TaskManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskManager)
        }
    }
}
