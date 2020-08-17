//
//  NewCourseViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation

struct NewCourseViewModel {
    
    func verifyContents(name: String, professor: String, location: String, frequency: [Int], startTime: Date, endTime: Date, handler: @escaping (Result<Void, NewCourseValidationError>) -> Void) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedProfessor = professor.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName == "" {
            handler(.failure(NewCourseValidationError.name))
        } else if trimmedProfessor == "" {
            handler(.failure(NewCourseValidationError.professor))
        } else if trimmedLocation == "" {
            handler(.failure(NewCourseValidationError.location))
        } else if frequency.count == 0 {
            handler(.failure(NewCourseValidationError.frequency))
        } else if !isTimeFrameValid(startTime: startTime, endTime: endTime) {
            handler(.failure(NewCourseValidationError.timeFrame))
        } else {
            handler(.success(Void()))
        }
    }
    
    private func isTimeFrameValid(startTime: Date, endTime: Date) -> Bool {
        return startTime < endTime
    }
    
}
