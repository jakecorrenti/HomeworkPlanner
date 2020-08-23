//
//  CourseDetailViewModel.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

struct CourseDetailViewModel {
    
    func convertTimeFrame(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
    }
    
    private func convertFetchedResultsToArray<T>(_ results: FetchedResults<T>) -> [T] {
        var items = [T]()
        results.forEach{ items.append($0) }
        return items
    }
    
    func fetchAssignmentsFor(course: Course, data: FetchedResults<Assignment>) -> [Assignment] {
        convertFetchedResultsToArray(data).filter { $0.course == course }
    }
    
    func fetchCompleteAssignments(for course: Course, data: FetchedResults<Assignment>) -> [Assignment] {
        let assignments = convertFetchedResultsToArray(data)
        var completedAssignments = [Assignment]()
        
        for assignment in assignments {
            if assignment.course == course && assignment.isComplete {
                completedAssignments.append(assignment)
            }
        }
        return completedAssignments.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
    }
    
    func fetchIncompleteAssignments(for course: Course, data: FetchedResults<Assignment>) -> [Assignment] {
        let assignments = convertFetchedResultsToArray(data)
        var incompleteAssignments = [Assignment]()
        
        for assignment in assignments {
            if assignment.course == course && !assignment.isComplete {
                incompleteAssignments.append(assignment)
            }
        }
        return incompleteAssignments.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
    }
    
    func fetchOverdueAssignments(for course: Course, data: FetchedResults<Assignment>) -> [Assignment] {
        let incompleteAssignments = fetchIncompleteAssignments(for: course, data: data)
        var overDueAssignments = [Assignment]()
        
        for assignment in incompleteAssignments where assignment.dueDate! < Date() {
            overDueAssignments.append(assignment)
        }
        let chronological = overDueAssignments.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date()}
        return chronological.filter { !$0.isComplete } + chronological.filter { $0.isComplete }
    }
    
    /// Assignments key gives list of all assignments, complete key gives list of completed assignments, incomplete key gives list of incomplete assignments
    func fetchAssignmentsDueTodayData(for course: Course, data: FetchedResults<Assignment>) -> [String : [Assignment]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "M/dd/yyyy"
        
        let assignments = fetchAssignmentsFor(course: course, data: data)
        let dueToday = assignments.filter { formatter.string(from: $0.dueDate ?? Date()) == formatter.string(from: Date())}
        let complete = dueToday.filter { $0.isComplete }
        let incomplete = dueToday.filter { !$0.isComplete }
        
        let chronological = dueToday.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        
        return [
            "assignments" : chronological.filter { !$0.isComplete } + chronological.filter { $0.isComplete },
            "complete" : complete.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() },
            "incomplete" : incomplete.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        ]
    }
    
    /// Assignments key gives list of all assignments, complete key gives list of completed assignments, incomplete key gives list of incomplete assignments
    func fetchCriticalPriorityAssignmentsData(for course: Course, data: FetchedResults<Assignment>) -> [String : [Assignment]] {
        let assignments = fetchAssignmentsFor(course: course, data: data)
        let criticalPriority = assignments.filter { $0.priority == 4 }
        let complete = criticalPriority.filter { $0.isComplete }
        let incomplete = criticalPriority.filter { !$0.isComplete }
        
        let chronological = criticalPriority.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        
        return [
            "assignments" : chronological.filter { !$0.isComplete } + chronological.filter { $0.isComplete },
            "complete" : complete.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() },
            "incomplete" : incomplete.sorted { $0.dueDate ?? Date() < $1.dueDate ?? Date() }
        ]
    }
    
}
