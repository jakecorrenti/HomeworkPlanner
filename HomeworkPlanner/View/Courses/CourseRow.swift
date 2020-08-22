//
//  CourseRow.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseRow: View {
    @ObservedObject var course: Course
    
    private let viewModel = CourseRowViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(course.name ?? "Unknown course")
                    .font(.headline)
                    .bold()
                Text(CourseType.allCases[Int(course.type)].rawValue)
                    .bold()
                    .font(.caption)
                    .padding(2)
                    .background(course.type == 0 ? Color.purple.opacity(0.2) : course.type == 1 ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(course.type == 0 ? .purple : course.type == 1 ? .green : .blue)
                    .cornerRadius(4)
            }
            
            HStack {
                ImageWithLabelView(image: Image(systemName: Images.person), label: course.professor ?? "Unknown professor", font: .subheadline)
                Spacer()
                HStack {
                    Text("\(viewModel.convertTimeFrame(start: course.start ?? Date(), end: course.end ?? Date().addingTimeInterval(60)))")
                        .foregroundColor(.secondary)
                    Image(systemName: Images.clock)
                }
                .font(.subheadline)
            }
            
            HStack {
                ImageWithLabelView(image: Image(systemName: Images.map), label: course.location ?? "Unknown location", font: .subheadline)
                Spacer()
                HStack {
                    Text(self.viewModel.getFrequencyInitials(course: self.course))
                        .foregroundColor(.secondary)
                    Image(systemName: Images.calendar)
                }
                .font(.subheadline)
            }
        }
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return CourseRow(course: Course())
            .environment(\.managedObjectContext, context)
            .previewLayout(.sizeThatFits)
    }
}
