//
//  CalendarAddTaskSheet.swift
//  Task Tracker
//
//  Created by Indexer on 6/7/26.
//

import SwiftUI
import SwiftData

struct CalendarAddTaskSheet: View {

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var notes = ""
    @State private var date: Date

    init(date: Date) {
        _date = State(initialValue: date)
    }

    var body: some View {
        NavigationStack {
            Form {

                TextField("Title", text: $title)
                TextField("Notes", text: $notes)

                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        modelContext.insert(Task(title: title, notes: notes, startDate: date))
        dismiss()
    }
}
