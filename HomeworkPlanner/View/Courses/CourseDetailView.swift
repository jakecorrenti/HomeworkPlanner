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
    @State private var showEdit = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageWithLabelView(image: Image(systemName: Images.person), label: course.professor!, hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.clock), label: viewModel.convertTimeFrame(start: course.start!, end: course.end!), hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.map), label: course.location!, hasSpacer: true, font: .body)
                ImageWithLabelView(image: Image(systemName: Images.folder), label: CourseType.allCases[Int(course.type)].rawValue, hasSpacer: true, font: .body)
                Spacer()
                    .frame(height: 24)
                CourseDetailFrequencyView(frequency: course.frequency!)
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
        .navigationBarTitle(course.name!)
        .navigationBarItems(trailing: HStack(spacing: 16) {
            Button(action: { self.showEdit.toggle() }) { Text("Edit")}
                .sheet(isPresented: $showEdit, content: {
                    EditCourseView(course: self.course)
                        .environment(\.managedObjectContext, self.moc)
                })
            Button(action: {}) { Image(systemName: Images.plus) }
        })
        .sheet(isPresented: $showAllAssignments, content: {
            AllCourseAssignmentsView(assignments: self.viewModel.fetchAssignmentsFor(course: self.course, data: self.assignments))
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
