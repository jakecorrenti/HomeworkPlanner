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
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 8)
                .foregroundColor(course.type == 0 ? .purple : course.type == 1 ? .green : .blue)
            VStack(alignment: .leading) {
                Text(course.name!)
                    .font(Font(UIFont.preferredFont(forTextStyle: .title2)))
                    .fontWeight(.semibold)
                ImageWithLabelView(image: Image(systemName: Images.person), label: course.professor!)
                ImageWithLabelView(image: Image(systemName: Images.clock), label: "\(viewModel.convertTimeFrame(start: course.start!, end: course.end!)) \(course.frequency!.count) \(course.frequency!.count == 1 ? "day" : "days") a week")
                ImageWithLabelView(image: Image(systemName: Images.map), label: course.location!)
                ImageWithLabelView(image: Image(systemName: Images.folder), label: CourseType.allCases[Int(course.type)].rawValue)
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
