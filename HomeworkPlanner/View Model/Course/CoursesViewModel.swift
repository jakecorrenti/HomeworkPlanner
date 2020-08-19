//
//  CoursesViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct CoursesViewModel {
    
    func delete(course: Course, with context: NSManagedObjectContext) {
        
        for assignment in course.assignments ?? NSSet() {
            deletePendingNotifications(for: assignment as! Assignment)
        }
        
        context.delete(course)
        
        do {
            try context.save()
        } catch {
            print("🔴 ERROR: \(error.localizedDescription)")
        }
    }
    
    private func deletePendingNotifications(for assignment: Assignment) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [assignment.id?.uuidString ?? UUID().uuidString])
    }
    
}
