//
//  CoursesView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CoursesView: View {
    
    private var viewModel = CoursesViewModel()
    
    @FetchRequest(entity: Course.entity(), sortDescriptors: []) var courses: FetchedResults<Course>
    @FetchRequest(entity: Assignment.entity(), sortDescriptors: []) var assignments: FetchedResults<Assignment>
    @State private var showNewCourse = false
    @Environment(\.managedObjectContext) var moc
    
    init() {
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(courses, id: \.id) { course in
                    NavigationLink(destination: CourseDetailView(course: course)) {
                        CourseRow(course: course)
                    }
                }
                .onDelete(perform: delete)
            }
            .sheet(isPresented: $showNewCourse) {
                NewCourseView()
                    .environment(\.managedObjectContext, self.moc)
            }
            .navigationBarTitle("Courses")
            .navigationBarItems(trailing:
                Button(
                    action: { self.showNewCourse.toggle() },
                    label: { Image(systemName: Images.plus) }
                )
            )
        }.onAppear {
            print(self.assignments)
            print()
            UNUserNotificationCenter.current().getPendingNotificationRequests { (notifs) in
                notifs.forEach { print($0.identifier) }
                print()
                notifs.forEach { print($0.content) }
                print()
                print(notifs.count)
            }
        }
    }
    
    func delete(offset: IndexSet) {
        for index in offset {
            viewModel.delete(course: courses[index], with: moc)
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
