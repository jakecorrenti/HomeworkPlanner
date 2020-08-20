//
//  AssignmentRow.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentRow: View {
    
    @ObservedObject var assignment: Assignment
    var viewModel = AssignmentRowViewModel()
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                withAnimation {
                    self.viewModel.changeCompletionStatus(assignment: self.assignment, context: self.moc)
                }
            }) {
                Image(systemName: self.assignment.isComplete ? Images.checkboxFilled : Images.square)
                    .foregroundColor(self.assignment.isComplete ? .green : .primary)
            }.buttonStyle(BorderlessButtonStyle())
            VStack(alignment: .leading) {
                HStack {
                    if self.assignment.priority > 0 {
                        Image(systemName: Images.filledFlag)
                            .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                            .foregroundColor(priorityColors[Int(self.assignment.priority)])
                    }
                    Text(self.assignment.name ?? "Unknown assignment")
                        .strikethrough(self.assignment.isComplete, color: .primary)
                        .font(Font(UIFont.preferredFont(forTextStyle: .headline)))
                        .lineLimit(1)
                    Spacer()
                        .frame(width: 16)
                    Text(AssignmentType.allCases[Int(self.assignment.type)].rawValue)
                        .bold()
                        .padding(2)
                        .background(self.assignment.course?.type == 0 ? Color.purple.opacity(0.2) : self.assignment.course?.type == 1 ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                        .foregroundColor(self.assignment.course?.type == 0 ? .purple : self.assignment.course?.type == 1 ? .green : .blue)
                        .font(.caption)
                        .cornerRadius(4)
                    if !self.assignment.isComplete && (self.assignment.dueDate ?? Date() < Date()) {
                        Text("Over due")
                            .bold()
                            .padding(2)
                            .foregroundColor(.red)
                            .font(.caption)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
                Spacer()
                    .frame(height: 8)
                Text(self.assignment.details ?? "Unknown details")
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .font(.caption)
                HStack {
                    ImageWithLabelView(image: Image(systemName: Images.clock), label: self.viewModel.convertDateFormat(date: self.assignment.dueDate ?? Date()))
                    Spacer()
                    ImageWithLabelView(image: self.assignment.reminderTiming > 0 ? Image(systemName: Images.bell) : Image(systemName: Images.bellSlashed) , label: AssignmentReminderTiming.allCases[Int(self.assignment.reminderTiming)].rawValue)
                }
            }
        }
    }
}

struct AssignmentRow_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentRow(assignment: Assignment())
            .previewLayout(.sizeThatFits)
    }
}
