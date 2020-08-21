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
}
