//
//  CalendarView.swift
//  Task Tracker
//
//  Created by Indexer on 6/7/26.
//

import SwiftData
import SwiftUI

struct CalendarView: View {

    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskTitle = ""

    @State private var selectedDates: Set<DateComponents> = []
    @State private var showAddSheet = false
    @State private var selectedDate = Date()

    var body: some View {
        NavigationStack {
            VStack {

                header

                MultiDatePicker("Dates", selection: $selectedDates)
                    .tint(.green)
                    .frame(height: 320)
                

                List {
                    ForEach(tasks) { task in
                        NavigationLink {
                            TaskDetailView(task: task)
                        } label: {
                            TaskRowView(
                                task:  task,
                                onToggle: {
                                    toggleTask(task)
                                }
                            )
                        }
                        
                    }
                    
                    .onDelete(perform: deleteTask)
                }
                .listStyle(.plain)
            }
            .sheet(isPresented: $showAddSheet) {
                CalendarAddTaskSheet(date: selectedDate)
            }
            .onAppear {
                if selectedDates.isEmpty {
                    let today = Calendar.current.dateComponents(
                        [.year, .month, .day],
                        from: .now
                    )
                    selectedDates.insert(today)
                }
            }
        }
    }
}

// MARK: Logic
extension CalendarView {

    fileprivate var filteredTasks: [Task] {
        let calendar = Calendar.current

        return tasks.filter { task in
            selectedDates.contains {
                guard let date = calendar.date(from: $0) else { return false }
                return calendar.isDate(task.startDate, inSameDayAs: date)
            }
        }
        .sorted { $0.startDate < $1.startDate }
    }

    fileprivate var header: some View {
        HStack {
            Text("Calendar")
                .font(.largeTitle)
                .bold()

            Spacer()

            Button {
                selectedDate = .now
                showAddSheet = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(.green)
            }
        }
        .padding()
    }

    fileprivate func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }

        let newTask = Task(title: trimmed)
        modelContext.insert(newTask)

        newTaskTitle = ""
    }

    fileprivate func toggleTask(_ task: Task) {
        task.isCompleted.toggle()
    }

    fileprivate func deleteTask(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }

    fileprivate var completedTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }

}
