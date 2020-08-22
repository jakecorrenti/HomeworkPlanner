//
//  AssignmentsViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/22/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
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
    
    func filterAssignments(state: Int, data: FetchedResults<Assignment>) -> [Assignment] {
        let chronologicalSort = data.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        
        switch state {
        case 0:
            return chronologicalSort.filter { !$0.isComplete } + chronologicalSort.filter { $0.isComplete }
        case 1:
            return chronologicalSort.filter { !$0.isComplete }
        case 2:
            return chronologicalSort.filter { $0.isComplete }
        default:
            return chronologicalSort
        }
    }
}
