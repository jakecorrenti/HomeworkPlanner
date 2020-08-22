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
        let notifsService = NotificationsService()
        
        for assignment in course.assignments ?? NSSet() {
            guard let assignment = assignment as? Assignment else { return }
            notifsService.removeReminder(id: assignment.id?.uuidString)
        }
        
        context.delete(course)
        
        do {
            try context.save()
        } catch {
            print("🔴 ERROR: \(error.localizedDescription)")
        }
    }
    
}
