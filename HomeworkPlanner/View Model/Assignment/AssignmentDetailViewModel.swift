//
//  AssignmentDetailViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/20/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct AssignmentDetailViewModel {
    
    func changeCompletionStatus(assignment: Assignment, context: NSManagedObjectContext) {
        assignment.isComplete = !assignment.isComplete
        
        try? context.save()
    }
    
    func hasAlreadyBeenNotified(assignment: Assignment) -> Bool {
        determineReminderDate(timing: AssignmentReminderTiming.allCases[Int(assignment.reminderTiming)], dueDate: assignment.dueDate ?? Date()) < Date()
    }
    
    private func determineReminderDate(timing: AssignmentReminderTiming, dueDate: Date) -> Date {
        switch timing {
        case .current:
            return dueDate
        case .five:
            return Calendar.current.date(byAdding: .minute, value: -5, to: dueDate) ?? Date()
        case .ten:
            return Calendar.current.date(byAdding: .minute, value: -10, to: dueDate) ?? Date()
        case .fifteen:
            return Calendar.current.date(byAdding: .minute, value: -15, to: dueDate) ?? Date()
        case .thirty:
            return Calendar.current.date(byAdding: .minute, value: -30, to: dueDate) ?? Date()
        case .hour:
            return Calendar.current.date(byAdding: .hour, value: -1, to: dueDate) ?? Date()
        case .twoHours:
            return Calendar.current.date(byAdding: .hour, value: -2, to: dueDate) ?? Date()
        case .day:
            return Calendar.current.date(byAdding: .day, value: -1, to: dueDate) ?? Date()
        case .twoDays:
            return Calendar.current.date(byAdding: .day, value: -2, to: dueDate) ?? Date()
        case .week:
            return Calendar.current.date(byAdding: .day, value: -7, to: dueDate) ?? Date()
        default:
            return Date()
        }
    }
}
