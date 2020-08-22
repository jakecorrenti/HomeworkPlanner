//
//  NotificationsService.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/20/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationsService {
    func verifyReminerTiming(_ timing: AssignmentReminderTiming, dueDate: Date) -> Bool {
        determineReminderDate(timing: timing, dueDate: dueDate) > Date()
    }
    
    func determineReminderDate(timing: AssignmentReminderTiming, dueDate: Date) -> Date {
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
    
    func createReminder(assignment: Assignment, completion: @escaping (NewAssignmentValidationError?) -> Void) {
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
    
    func removeReminder(id: String?) {
        guard let id = id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
