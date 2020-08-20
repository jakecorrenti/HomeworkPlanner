//
//  AssignmentRowViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct AssignmentRowViewModel {

    func convertDateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd h:mm a"
        
        return formatter.string(from: date)
    }
    
    func changeCompletionStatus(assignment: Assignment, context: NSManagedObjectContext) {
        assignment.isComplete = !assignment.isComplete
        
        try? context.save()
    }
}
