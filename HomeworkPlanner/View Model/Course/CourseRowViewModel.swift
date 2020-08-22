//
//  CourseRowViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseRowViewModel {
    func convertTimeFrame(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
    
    func getFrequencyInitials(course: Course) -> String {
        var string = ""
        
        for (i, day) in (course.frequency ?? [Int]()).enumerated() {
            string.append(daysInitials[day].uppercased())
            if i < (course.frequency ?? [Int]()).count - 1 {
                string.append(", ")
            }
        }
        
        return string
    }
}
