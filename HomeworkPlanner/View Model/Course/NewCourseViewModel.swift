//
//  NewCourseViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation
import CoreData

struct NewCourseViewModel {
    
    private func verifyContents(name: String, professor: String, location: String, frequency: [Int], startTime: Date, endTime: Date, handler: @escaping (Result<Void, NewCourseValidationError>) -> Void) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedProfessor = professor.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName == "" {
            handler(.failure(.name))
        } else if trimmedProfessor == "" {
            handler(.failure(.professor))
        } else if trimmedLocation == "" {
            handler(.failure(.location))
        } else if frequency.count == 0 {
            handler(.failure(.frequency))
        } else if !isTimeFrameValid(startTime: startTime, endTime: endTime) {
            handler(.failure(.timeFrame))
        } else {
            handler(.success(Void()))
        }
    }
    
    private func isTimeFrameValid(startTime: Date, endTime: Date) -> Bool {
        startTime < endTime
    }
    
    func saveCourse(context: NSManagedObjectContext, name: String, professor: String, location: String, type: Int, frequency: [Int], startTime: Date, endTime: Date, handler: @escaping (Result<Void, NewCourseValidationError>) -> Void) {
        verifyContents(name: name, professor: professor, location: location, frequency: frequency, startTime: startTime, endTime: endTime) { (result) in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(_):
                let course = Course(context: context)
                course.id = UUID()
                course.name = name
                course.professor = professor
                course.location = location
                course.type = Int16(type)
                course.frequency = frequency
                course.start = startTime
                course.end = endTime
                 
                do {
                    try context.save()
                    handler(.success(Void()))
                } catch {
                    handler(.failure(.saveFailure))
                }
            }
        }
    }
    
}
