//
//  EditCourseViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI
import CoreData

struct EditCourseViewModel {
    
    private func validateCourseUpdates(course: Course, error: @escaping (NewCourseValidationError?) -> Void) {
        let trimmedName = course.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedProfessor = course.professor?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = course.location?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName == "" {
            error(.name)
        } else if trimmedProfessor == "" {
            error(.professor)
        } else if trimmedLocation == "" {
            error(.location)
        } else if course.frequency?.count == 0 {
            error(.frequency)
        } else if !verifyCourseTimeFrame(start: course.start!, end: course.end!) {
            error(.timeFrame)
        } else {
            error(nil)
        }
    }
    
    func save(course: Course, updatedType: Int, context: NSManagedObjectContext, errorHandler: @escaping (NewCourseValidationError?) -> Void) {
        validateCourseUpdates(course: course) { (err) in
            if let err = err {
                errorHandler(err)
            } else {
                context.performAndWait {
                    course.type = Int16(updatedType)
                    try? context.save()
                    errorHandler(nil)
                }
            }
        }
    }
    
    private func verifyCourseTimeFrame(start: Date, end: Date) -> Bool {
        start < end
    }
}
