//
//  Task.swift
//  Task Tracker
//
//  Created by Indexer on 2/7/26.
// that its look like a data class in android 
//
import Foundation
import SwiftData

@Model
class Task {
    var id = UUID()
    var title:String
    var isCompleted:Bool = false
    
    init(title: String, isCompleted: Bool = false ) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

