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
    
    #warning("The view model data implementation is not yet developed for this view.")
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Work at a glance")
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HorizontalGlanceView(title: "Critical priority assignments", complete: 1, incomplete: 3, imageName: Images.person, color: .red)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .onTapGesture {
                        #warning("take this to the AllCourseAssignmentsView with filtered results")
                }
                
                HorizontalGlanceView(title: "Assignments due today", complete: 1, incomplete: 3, imageName: Images.calendar, color: .orange)
                    .padding(8)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .onTapGesture {
                        #warning("take this to the AllCourseAssignmentsView with filtered results")
                }
                
                HStack {
                    GlanceCardView(title: "Done", completed: 10, incomplete: 15, color: .green)
                        .onTapGesture {
                            #warning("take this to the AllCourseAssignmentsView with filtered results")
                    }
                    GlanceCardView(title: "Not done", completed: 2, incomplete: 15, color: .primary)
                        .onTapGesture {
                            #warning("take this to the AllCourseAssignmentsView with filtered results")
                    }
                    GlanceCardView(title: "Over due", completed: 3, incomplete: 15, color: .red)
                        .onTapGesture {
                            #warning("take this to the AllCourseAssignmentsView with filtered results")
                    }
                }
            }
            Spacer()
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
    var incomplete: Int
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
                Text("\(incomplete)")
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
