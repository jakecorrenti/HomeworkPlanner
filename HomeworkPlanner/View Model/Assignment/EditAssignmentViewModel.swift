//
//  EditAssignmentViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/20/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct EditAssignmentViewModel {
    
    func sortCoursesAscending(courses: FetchedResults<Course>) -> [Course] {
        courses.sorted { $0.name ?? "Unknown" < $1.name ?? "Unkonwn"}
    }
    
    private func verifyContents(assignment: Assignment, updatedReminder: Int, completion: @escaping (NewAssignmentValidationError?) -> Void) {
        let trimmedName = assignment.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = assignment.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let notifs = NotificationsService()
        
        if trimmedName == "" {
            completion(.name)
        } else if trimmedDescription == "" {
            completion(.details)
        } else if updatedReminder != assignment.reminderTiming && updatedReminder > 0 && !notifs.verifyReminerTiming(AssignmentReminderTiming.allCases[updatedReminder], dueDate: assignment.dueDate ?? Date()) {
            completion(.reminder)
        } else {
            completion(nil)
        }
    }
    
    func save(assignment: Assignment, initialDueDate: Date, updatedType: Int, updatedPriority: Int, updatedReminderTiming: Int, context: NSManagedObjectContext, completion: @escaping (NewAssignmentValidationError?) -> Void) {
        
        let service = NotificationsService()

        verifyContents(assignment: assignment, updatedReminder: updatedReminderTiming) { (error) in
            if let error = error {
                completion(error)
            } else {
                
                // add the assignment changes
                assignment.type = Int16(updatedType)
                assignment.priority = Int16(updatedPriority)
                assignment.reminderTiming = Int16(updatedReminderTiming)
                
                if assignment.dueDate != initialDueDate || assignment.reminderTiming != updatedReminderTiming {
                    // remove the original reminder
                    service.removeReminder(id: assignment.id?.uuidString ?? UUID().uuidString)
                    if updatedReminderTiming > 0 {
                        // create the new reminder
                        service.createReminder(assignment: assignment) { (error) in
                            if let error = error {
                                completion(error)
                            }
                        }
                    }
                }
                
                // save the assignment edits
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
