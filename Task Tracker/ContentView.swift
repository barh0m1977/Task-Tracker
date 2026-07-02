//
//  ContentView.swift
//  Task Tracker
//
//  Created by Indexer on 2/7/26.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Query private var tasks : [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskTitle = ""
    var body: some View {
     
            VStack {
                Text("Task Tracker")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text(tasks.isEmpty ?  "" : "you have to complete \(completedTasksCount) task").font(.subheadline).fontWeight(.light)
                HStack{
                    TextField("New Task",text: $newTaskTitle).textFieldStyle(.roundedBorder)
                    Button("Add"){
                      addTask()
                
                    }.buttonStyle(.glassProminent).disabled(newTaskTitle.isEmpty)
                }
                // List of Tasks
                List{
                    ForEach(tasks){task in
                        HStack{
                                Text(task.title).strikethrough(task.isCompleted).foregroundStyle(task.isCompleted ? Color(.gray) : Color(.black))
                            Spacer()
                            Image(systemName: task.isCompleted ? "checkmark.seal.fill" : "circlebadge")
                            
                                .foregroundStyle(task.isCompleted ? Color(.blue) : Color(.systemBlue))
                                .onTapGesture {
                                    toggleTask(task )
                                }
                        }
                    }.onDelete(perform: deleteTask)
                    
                }.listStyle(.plain)
                
            }.padding()
            
        
    }
    
    private func addTask(){
        let newTask = Task(title: newTaskTitle)
            modelContext.insert(newTask)
            newTaskTitle = ""
     
    }
    
    private func toggleTask(_ task:Task){
        task.isCompleted.toggle()
    }
    
    private func deleteTask(at offset : IndexSet){
            for index in offset{
                modelContext.delete(tasks[index])
            }
    }
    private var completedTasksCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
}

#Preview {
    ContentView()
}
