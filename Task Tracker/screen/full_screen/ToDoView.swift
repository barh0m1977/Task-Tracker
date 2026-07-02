//
//  ToDoView.swift
//  Task Tracker
//
//  Created by Indexer on 6/7/26.
//

import SwiftUI
import SwiftData

struct ToDoView: View {

    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext

    @State private var newTaskTitle = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                header

                addTaskBar

                List {
                    ForEach(tasks) { task in
                        NavigationLink {
                            TaskDetailView(task: task)
                        } label: {
                            TaskRowView(task: task) {
                                task.isCompleted.toggle()
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .listStyle(.plain)
            }
            .padding()
        }
    }
}

// MARK: UI
private extension ToDoView {

    var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Task Tracker")
                .font(.largeTitle)
                .bold()

            Text("\(activeTasksCount) active tasks")
                .foregroundStyle(.secondary)
        }
    }

    var addTaskBar: some View {
        HStack {
            TextField("New Task", text: $newTaskTitle)
                .textFieldStyle(.roundedBorder)

            Button("Add") {
                addTask()
            }
            .disabled(newTaskTitle.trimmingCharacters(in: .whitespaces).isEmpty)
        }
    }
}

// MARK: Logic
private extension ToDoView {

    var activeTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }

    func addTask() {
        let title = newTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !title.isEmpty else { return }

        modelContext.insert(Task(title: title))
        newTaskTitle = ""
    }

    func deleteTask(at offsets: IndexSet) {
        offsets.map { tasks[$0] }.forEach(modelContext.delete)
    }
}


