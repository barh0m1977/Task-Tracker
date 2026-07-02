//
//  Task_TrackerApp.swift
//  Task Tracker
//
//  Created by Indexer on 2/7/26.
//

import SwiftUI
import SwiftData

@main
struct Task_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : Task.self)
    }
}
