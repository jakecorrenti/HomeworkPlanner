//
//  CourseDetailView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseDetailView: View {
    var course: Course
    
    var viewModel = CourseDetailViewModel()
    
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
            }
            .padding(.horizontal)
        }
        .navigationBarTitle(course.name!)
    }
}

struct CourseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDetailView(course: Course())
        }
    }
}
