//
//  CourseDetailView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseDetailView: View {
    @ObservedObject var course: Course
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignments: FetchedResults<Assignment>
    @Environment(\.managedObjectContext) var moc 
    
    var viewModel = CourseDetailViewModel()
    
    @State private var showAllAssignments = false
    @State private var showEditView = false
    @State private var showNewAssignment = false
    @State private var state: CourseWorkAtAGlanceState = .all
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageWithLabelView(image: Image(systemName: Images.person), label: course.professor ?? "Course professor", hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.clock), label: viewModel.convertTimeFrame(start: course.start ?? Date(), end: course.end ?? Date().addingTimeInterval(60)), hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.map), label: course.location ?? "Course location", hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.folder), label: CourseType.allCases[Int(course.type)].rawValue, hasSpacer: true, font: .body)
                Spacer()
                    .frame(height: 24)
                CourseDetailFrequencyView(frequency: course.frequency ?? [0])
                Spacer()
                    .frame(height: 24)
                CourseWorkGlanceView(course: course)
                Spacer()
                    .frame(height: 36)
                Button(action: {
                    self.showAllAssignments.toggle()
                }) {
                    HStack {
                        Spacer()
                        Text("See all assignments (\(course.assignments?.count ?? 0))")
                            .foregroundColor(.white)
                            .bold()
                        Spacer()
                    }
                }
                .frame(height: 44)
                .background(Color.accentColor)
                .cornerRadius(12)
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(course.name ?? "Course name")
        .navigationBarItems(trailing: HStack(spacing: 16) {
            Button(action: { self.showEditView.toggle() }) { Text("Edit")}
                .sheet(isPresented: $showEditView, content: {
                    EditCourseView(course: self.course)
                        .environment(\.managedObjectContext, self.moc)
                })
            Button(action: { self.showNewAssignment.toggle() }) { Image(systemName: Images.plus) }
                .sheet(isPresented: $showNewAssignment, content: {
                    NewAssignmentView(course: self.course)
                        .environment(\.managedObjectContext, self.moc)
                })
        })
        .sheet(isPresented: $showAllAssignments, content: {
            AllCourseAssignmentsView(course: self.course, state: self.state)
                .environment(\.managedObjectContext, self.moc)
        })
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDetailView(course: Course())
        }
    }
}
