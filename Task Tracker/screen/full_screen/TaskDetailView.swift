//
//  TaskDetailView.swift
//  Task Tracker
//
//  Created by Indexer on 4/7/26.
//

import SwiftUI
import SwiftData

struct TaskDetailView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Bindable var task: Task

    var body: some View {
        Form {

            Section("General") {
                TextField("Title", text: $task.title)
                TextEditor(text: $task.notes)
            }

            Section("Schedule") {
                Toggle("All Day", isOn: $task.isAllDay)

                DatePicker(
                    "Start",
                    selection: $task.startDate,
                    displayedComponents: task.isAllDay ? [.date] : [.date, .hourAndMinute]
                )
            }

            Section("Status") {
                Toggle("Completed", isOn: $task.isCompleted)
            }

            Section {
                Button(role: .destructive) {
                    modelContext.delete(task)
                    dismiss()
                } label: {
                    Text("Delete Task")
                }
            }
        }
        .navigationTitle(task.title)
    }
}
