//
//  AssignmentRow.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentRow: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: Images.checkboxFilled)
                .foregroundColor(.green)
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: Images.filledFlag)
                        .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                        .foregroundColor(.red)
                    Text("Computing 1 Lab")
                        .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                    Spacer()
                        .frame(width: 16)
                    Text("Lab")
                        .bold()
                        .padding(2)
                        .foregroundColor(.accentColor)
                        .font(.caption)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(4)
                }
                Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut… ")
                    .lineLimit(2)
                    .font(.footnote)
                HStack {
                    ImageWithLabelView(image: Image(systemName: Images.clock), label: "8/19 9:00 AM")
                    Spacer()
                    ImageWithLabelView(image: Image(systemName: Images.bell), label: "30 minutes before")
                }
            }
        }
    }
}

struct AssignmentRow_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentRow()
            .previewLayout(.sizeThatFits)
    }
}
