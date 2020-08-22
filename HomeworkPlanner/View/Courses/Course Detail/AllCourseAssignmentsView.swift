//
//  AllCourseAssignmentsView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AllCourseAssignmentsView: View {
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignments: FetchedResults<Assignment>
    @Environment(\.managedObjectContext) var moc 
    
    var course: Course
    var state: CourseWorkAtAGlanceState
    let viewModel = AllCourseAssignmentsViewModel()
    let assignmentsViewModel = AssignmentsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.retrieveInsightAssignmnents(course: self.course, data: self.assignments, state: self.state), id: \.id) { assignment in
                    ZStack {
                        AssignmentRow(assignment: assignment)
                            .padding(.vertical, 4)
                        NavigationLink(destination: AssignmentDetailView(assignment: assignment)) {
                            EmptyView()
                        }
                        .foregroundColor(.clear)
                        .frame(width: 0)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("Assignments", displayMode: .inline)
        }
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            self.assignmentsViewModel.deleteAssignment(assignment: self.assignments[index], context: self.moc)
        }
    }
}

struct AllCourseAssignmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AllCourseAssignmentsView(course: Course(), state: .all)
    }
}
