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
final class Task {

    @Attribute(.unique)
    var id: UUID

    // MARK: Content
    var title: String
    var notes: String

    // MARK: Status
    var isCompleted: Bool

    // MARK: Schedule
    var startDate: Date
    var endDate: Date?
    var reminderDate: Date?
    var isAllDay: Bool

    // MARK: Metadata
    var priority: Priority
    var repeatRule: RepeatRule

    init(
        title: String,
        notes: String = "",
        startDate: Date = .now,
        endDate: Date? = nil,
        reminderDate: Date? = nil,
        isAllDay: Bool = false,
        priority: Priority = .medium,
        repeatRule: RepeatRule = .none
    ) {
        self.id = UUID()
        self.title = title
        self.notes = notes
        self.isCompleted = false

        self.startDate = startDate
        self.endDate = endDate
        self.reminderDate = reminderDate
        self.isAllDay = isAllDay

        self.priority = priority
        self.repeatRule = repeatRule
    }
}
