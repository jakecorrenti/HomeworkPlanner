//
//  CourseWorkGlanceView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseWorkGlanceView: View {
    var course: Course
    let viewModel = CourseDetailViewModel()
    
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignments: FetchedResults<Assignment>
    @State private var showAllAssignments = false
    @State private var state: CourseWorkAtAGlanceState = .all
    
    @Environment(\.managedObjectContext) var moc 
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Work at a glance")
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HorizontalGlanceView(title: "Critical priority assignments", complete: viewModel.fetchCriticalPriorityAssignmentsData(for: course, data: assignments)["complete"]!.count, incomplete: viewModel.fetchCriticalPriorityAssignmentsData(for: course, data: assignments)["incomplete"]!.count, imageName: Images.person, color: .red)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .onTapGesture {
                        self.state = .critical
                        self.showAllAssignments.toggle()
                }
                
                HorizontalGlanceView(title: "Assignments due today", complete: viewModel.fetchAssignmentsDueTodayData(for: course, data: assignments)["complete"]!.count, incomplete: viewModel.fetchAssignmentsDueTodayData(for: course, data: assignments)["incomplete"]!.count, imageName: Images.calendar, color: .orange)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .onTapGesture {
                        self.state = .today
                        self.showAllAssignments.toggle()
                }
                
                HStack {
                    GlanceCardView(title: "Done", completed: viewModel.fetchCompleteAssignments(for: course, data: assignments).count, total: course.assignments?.count ?? 0, color: .green)
                        .onTapGesture {
                            self.state = .done
                            self.showAllAssignments.toggle()
                    }
                    GlanceCardView(title: "Not done", completed: viewModel.fetchIncompleteAssignments(for: self.course, data: self.assignments).count, total: course.assignments?.count ?? 0, color: .primary)
                        .onTapGesture {
                            self.state = .notDone
                            self.showAllAssignments.toggle()
                    }
                    GlanceCardView(title: "Over due", completed: viewModel.fetchOverdueAssignments(for: course, data: assignments).count, total: course.assignments?.count ?? 0, color: .red)
                        .onTapGesture {
                            self.state = .overDue
                            self.showAllAssignments.toggle()
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $showAllAssignments) {
            AllCourseAssignmentsView(course: self.course, state: self.state)
                .environment(\.managedObjectContext, self.moc)
        }
    }
}

struct HorizontalGlanceView: View {
    var title: String
    var complete: Int
    var incomplete: Int
    var imageName: String
    var color: Color
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(color)
                    .opacity(0.3)
                    .frame(width: 45, height: 45)
                Image(systemName: imageName)
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                Text("\(complete) Completed - \(incomplete) Incomplete")
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(color)
                    .opacity(0.3)
            }
            Spacer()
        }
    }
}

struct GlanceCardView: View {
    var title: String
    var completed: Int
    var total: Int
    var color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .frame(height: 150)
            VStack {
                Text("\(completed)")
                    .font(.title)
                    .bold()
                Text("\(total)")
                    .fontWeight(.semibold)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                    .opacity(0.5)
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(color)
        }
    }
}

struct CourseWorkGlanceView_Previews: PreviewProvider {
    static var previews: some View {
        CourseWorkGlanceView(course: Course())
    }
}
