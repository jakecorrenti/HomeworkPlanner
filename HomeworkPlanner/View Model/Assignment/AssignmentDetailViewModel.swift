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
        let notifsService = NotificationsService()
        return notifsService.determineReminderDate(timing: AssignmentReminderTiming.allCases[Int(assignment.reminderTiming)], dueDate: assignment.dueDate ?? Date()) < Date()
    }
    
    func convertDate(assignment: Assignment) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd h:mm a"
        
        return formatter.string(from: assignment.dueDate ?? Date())
    }
    
    func determineScoreMessage(score: Double) -> String {
        if (70...79).contains(score) {
            return "NICE!"
        } else if (80...89).contains(score) {
            return "GREAT!"
        } else if (90...99).contains(score) {
            return "AWESOME!"
        } else if score >= 100 {
            return "PERFECT!"
        } else {
            return ""
        }
    }
    
    func determineScoreColor(score: Double) -> Color {
        if (0...49).contains(score) {
            return .red
        } else if (50...59).contains(score) {
            return .orange
        } else if (60...79).contains(score) {
            return .yellow
        } else {
            return .green
        }
    }
}
