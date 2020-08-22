//
//  NewAssignmentViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct NewAssignmentViewModel {
    
    private func verify(name: String, details: String, dueDate: Date, reminderTiming: Int, error: @escaping (NewAssignmentValidationError?) -> Void) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDetails = details.trimmingCharacters(in: .whitespacesAndNewlines)
        let notifsService = NotificationsService()
        
        if trimmedName == "" {
            error(.name)
        } else if trimmedDetails == "" {
            error(.details)
        } else if Date() > dueDate {
            error(.date)
        } else if reminderTiming > 0 && !notifsService.verifyReminerTiming(AssignmentReminderTiming.allCases[reminderTiming], dueDate: dueDate) {
            error(.reminder)
        } else {
            error(nil)
        }
    }
    
    func save(course: Course, name: String, details: String, type: Int, priority: Int, dueDate: Date, reminderTiming: Int, context: NSManagedObjectContext, completion: @escaping (NewAssignmentValidationError?) -> Void) {
        verify(name: name, details: details, dueDate: dueDate, reminderTiming: reminderTiming) { (error) in
            if let error = error {
                completion(error)
            } else {
                let assignment = Assignment(context: context)
                assignment.id = UUID()
                assignment.name = name
                assignment.details = details
                assignment.type = Int16(type)
                assignment.priority = Int16(priority)
                assignment.dueDate = dueDate
                assignment.reminderTiming = Int16(reminderTiming)
                assignment.isComplete = false
                
                let updatedAssignments = course.assignments?.adding(assignment)
                course.assignments = updatedAssignments as NSSet?
                
                if assignment.reminderTiming > 0 {
                    let notifService = NotificationsService()
                    notifService.createReminder(assignment: assignment) { (error) in
                        if let _ = error {
                            completion(error)
                        }
                    }
                }
                
                do {
                    try context.save()
                    completion(nil)
                } catch {
                    completion(error as? NewAssignmentValidationError)
                }
            }
        }
    }
}
