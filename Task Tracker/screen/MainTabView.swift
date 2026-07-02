//
//  MainTabView.swift
//  Task Tracker
//
//  Created by Indexer on 6/7/26.
//

import SwiftUI

enum Tabs: String, CaseIterable {
    case home, tasks, calendar, settings
}

struct MainTabView: View {

    @State private var selected: Tabs = .tasks

    var body: some View {

        TabView(selection: $selected) {

            //            HomeView()
            //                .tabItem { Label("Home", systemImage: "house") }
            //                .tag(Tabs.home)

            ToDoView()
                .tabItem { Label("Tasks", systemImage: "checklist") }
                .tag(Tabs.tasks)

            CalendarView()
                .tabItem { Label("Calendar", systemImage: "calendar") }
                .tag(Tabs.calendar)

            //            SettingsView()
            //                .tabItem { Label("Settings", systemImage: "gear") }
            //                .tag(Tabs.settings)
        }
        .tint(.green)

    }
}
