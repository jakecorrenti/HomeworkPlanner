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
        
        if trimmedName == "" {
            error(.name)
        } else if trimmedDetails == "" {
            error(.details)
        } else if Date() > dueDate {
            error(.date)
        } else if reminderTiming > 0 && !verifyReminerTiming(AssignmentReminderTiming.allCases[reminderTiming], dueDate: dueDate) {
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
                    self.createReminder(assignment: assignment) { (error) in
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
    
    private func verifyReminerTiming(_ timing: AssignmentReminderTiming, dueDate: Date) -> Bool {
        determineReminderDate(timing: timing, dueDate: dueDate) > Date()
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
    
    private func createReminder(assignment: Assignment, completion: @escaping (NewAssignmentValidationError?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if success {
                self.configureNotification(assignment: assignment) { (error) in
                    if let _ = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            } else if let _ = error {
                completion(.creatingReminder)
            }
        }
    }
    
    private func configureNotification(assignment: Assignment, completion: @escaping (NewAssignmentValidationError?) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd h:mm a"
        
        let content = UNMutableNotificationContent()
        content.title = "Complete \(assignment.name ?? "Unknown assignment")"
        content.subtitle = assignment.course?.name ?? "Unknown course"
        content.body = "Due \(formatter.string(from: assignment.dueDate ?? Date()))"
        content.sound = .default
        
        let reminderTiming = determineReminderDate(timing: AssignmentReminderTiming.allCases[Int(assignment.reminderTiming)], dueDate: assignment.dueDate ?? Date())
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: DateComponents(
                calendar: .current,
                year: getReminderComponent(component: .year, dueDate: reminderTiming),
                month: getReminderComponent(component: .month, dueDate: reminderTiming),
                day: getReminderComponent(component: .day, dueDate: reminderTiming),
                hour: getReminderComponent(component: .hour, dueDate: reminderTiming),
                minute: getReminderComponent(component: .minute, dueDate: reminderTiming)
            ),
            repeats: false
        )
        
        let request = UNNotificationRequest(identifier: assignment.id?.uuidString ?? UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let _ = error {
                completion(.creatingReminder)
            } else {
                completion(nil)
            }
        }
    }
    
    private func getReminderComponent(component: Calendar.Component, dueDate: Date) -> Int? {
        Calendar.current.component(component, from: dueDate)
    }
}
