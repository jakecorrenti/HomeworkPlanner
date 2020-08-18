//
//  Constants.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation
import SwiftUI

enum Images {
    static let book = "book"
    static let plus = "plus"
    static let checkmark = "checkmark"
    static let person = "person"
    static let clock = "clock"
    static let map = "map"
    static let folder = "folder"
    static let threeExclamationPoints = "exclamationmark.3"
    static let calendar = "calendar"
    static let filledCircleCheckmark = "checkmark.circle.fill"
    static let trash = "trash"
}

enum CourseType: String, CaseIterable {
    case lecture = "Lecture"
    case lab = "Lab"
    case seminar = "Seminar"
}

enum Days: String, CaseIterable {
    case sunday = "Sunday"
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
}

enum AssignmentType: String, CaseIterable {
    case project = "Project"
    case essay = "Essay"
    case lab = "Lab"
    case assignment = "Assignment"
    case test = "Test"
    case midterm = "Midterm"
    case final = "Final"
    case presentation = "Presentation"
}

enum AssignmentReminderTiming: String, CaseIterable {
    case none = "None"
    case current = "At time of event"
    case five = "5 minutes before"
    case ten = "10 minutes before"
    case fifteen = "15 minutes before"
    case thirty = "30 minutes before"
    case hour = "1 hour before"
    case twoHours = "2 hours before"
    case day = "1 day before"
    case twoDays = "2 days before"
    case week = "1 week before"
}

enum PriorityStates: String, CaseIterable {
    case none = "None"
    case low = "Low"
    case moderate = "Moderate"
    case high = "High"
    case critical = "Critical"
}

let priorityColors: [Color] = [
    .primary,
    .green,
    .yellow,
    .orange,
    .red
]

let daysInitials = [
    "s",
    "m",
    "t",
    "w",
    "t",
    "f",
    "s"
]

enum NewCourseValidationError: String, Error {
    case name = "Invalid name entered"
    case professor = "Invalid professor entered"
    case location = "Invalid location entered"
    case frequency = "The course must be attended at least one day a week"
    case timeFrame = "The course cannot end before the start time"
    case saveFailure = "Unable to save your course"
}
