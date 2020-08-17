//
//  CoursesView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CoursesView: View {
    @State private var showNewCourse = false
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            Text("Hello World")
            .navigationBarTitle("Courses")
            .navigationBarItems(trailing:
                Button(
                    action: { self.showNewCourse.toggle() },
                    label: { Image(systemName: Images.plus) }
                )
            )
                .sheet(isPresented: $showNewCourse) {
                    NewCourseView()
                        .environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
