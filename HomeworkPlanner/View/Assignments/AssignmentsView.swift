//
//  AssignmentsView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentsView: View {
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignments: FetchedResults<Assignment>
    @Environment(\.managedObjectContext) var moc
    
    let viewModel = AssignmentsViewModel()
    
    @State private var assignmentsCompletionState = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $assignmentsCompletionState, label: Text("Filter")) {
                    ForEach(0..<AssignmentsFilter.allCases.count, id: \.self) { index in
                        Text(AssignmentsFilter.allCases[index].rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                List {
                    ForEach(self.viewModel.filterAssignments(state: self.assignmentsCompletionState, data: self.assignments), id: \.id) { assignment in
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
                .navigationBarTitle("Assignments")
                .navigationBarTitle("Assignments")
            }
        }
    }
    
    func delete(indexSet: IndexSet) {
        for index in indexSet {
            self.viewModel.deleteAssignment(assignment: self.assignments[index], context: self.moc)
        }
    }
}

struct AssignmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentsView()
    }
}
