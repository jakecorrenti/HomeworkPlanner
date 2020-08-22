//
//  AllCourseAssignmentsViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/22/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AllCourseAssignmentsViewModel {
    
    func retrieveInsightAssignmnents(course: Course, data: FetchedResults<Assignment>, state: CourseWorkAtAGlanceState) -> [Assignment] {
        let courseDetailViewModel = CourseDetailViewModel()
        
        switch state {
        case .all:
            return courseDetailViewModel.fetchAssignmentsFor(course: course, data: data)
        case .critical:
            return courseDetailViewModel.fetchCriticalPriorityAssignmentsData(for: course, data: data)["assignments"]!
        case .done:
            return courseDetailViewModel.fetchCompleteAssignments(for: course, data: data)
        case .notDone:
            return courseDetailViewModel.fetchIncompleteAssignments(for: course, data: data)
        case .overDue:
            return courseDetailViewModel.fetchOverdueAssignments(for: course, data: data)
        case .today:
            return courseDetailViewModel.fetchAssignmentsDueTodayData(for: course, data: data)["assignments"]!
        }
    }
}
