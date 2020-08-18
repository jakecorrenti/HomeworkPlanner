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
}
