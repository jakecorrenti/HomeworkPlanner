//
//  AssignmentsViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/22/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation
import CoreData

struct AssignmentsViewModel {
    
    func deleteAssignment(assignment: Assignment, context: NSManagedObjectContext) {
        context.delete(assignment)
        
        let notifsService = NotificationsService()
        notifsService.removeReminder(id: assignment.id?.uuidString)
        
        do {
            try context.save()
        } catch {
            print("🔴 Error: \(error.localizedDescription)")
        }
    }
}
