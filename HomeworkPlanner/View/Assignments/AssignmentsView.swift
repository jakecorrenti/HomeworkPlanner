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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(assignments, id: \.id) { assignment in
                    NavigationLink(destination: AssignmentDetailView()) {
                        Text(assignment.name ?? "Assignment name")
                    }
                }
            }
            .navigationBarTitle("Assignments")
        }
    }
}

struct AssignmentsView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentsView()
    }
}
