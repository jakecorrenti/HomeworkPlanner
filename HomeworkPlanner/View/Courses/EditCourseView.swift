//
//  EditCourseView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct EditCourseView: View {
    @ObservedObject var course: Course
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                self.course.name = "HEY THERE DID THIS WORK"
                try? self.moc.save()
        }
    }
}

struct EditCourseView_Previews: PreviewProvider {
    static var previews: some View {
        EditCourseView(course: Course())
    }
}
