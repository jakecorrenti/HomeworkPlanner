//
//  AssignmentDetailView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var assignment: Assignment
    @State private var showCourseDetail = false
    @State private var showEdit = false
    
    let viewModel = AssignmentDetailViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                Text(AssignmentType.allCases[Int(self.assignment.type)].rawValue)
                    .bold()
                    .padding(2)
                    .background(self.assignment.course?.type == 0 ? Color.purple.opacity(0.2) : self.assignment.course?.type == 1 ? Color.green.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(self.assignment.course?.type == 0 ? .purple : self.assignment.course?.type == 1 ? .green : .blue)
                    .cornerRadius(4)
                if (self.assignment.dueDate ?? Date() < Date()) && !self.assignment.isComplete {
                    Text("Over due")
                        .bold()
                        .padding(2)
                        .background(Color.red.opacity(0.2))
                        .foregroundColor(.red)
                        .cornerRadius(4)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            ImageWithLabelView(image: Image(systemName: Images.clock), label: self.viewModel.convertDate(assignment: self.assignment), hasSpacer: true, font: .subheadline)
                .padding([.horizontal, .top])
            HStack {
                if self.assignment.reminderTiming > 0 {
                    Image(systemName: Images.bell)
                        .foregroundColor(self.viewModel.hasAlreadyBeenNotified(assignment: self.assignment) ? .green : .primary)
                } else {
                    Image(systemName: Images.bellSlashed)
                }
                
                Text(AssignmentReminderTiming.allCases[Int(self.assignment.reminderTiming)].rawValue)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .font(.subheadline)
            .padding(.horizontal)
            ImageWithLabelView(image: Image(systemName: Images.filledFlag), label: PriorityStates.allCases[Int(self.assignment.priority)].rawValue, hasSpacer: true, font: .subheadline)
                .padding(.horizontal)
                .foregroundColor(priorityColors[Int(self.assignment.priority)])
            HStack {
                Image(systemName: Images.book)
                Button(action: {
                    self.showCourseDetail.toggle()
                }) {
                    Text(self.assignment.course?.name ?? "Uknown course")
                }
                Spacer()
            }
            .font(.subheadline)
            .padding(.horizontal)
            
            HStack {
                Image(systemName: self.assignment.isComplete ? Images.checkboxFilled : Images.square)
                    .foregroundColor(self.assignment.isComplete ? .green : .primary)
                Button(action: {
                    self.viewModel.changeCompletionStatus(assignment: self.assignment, context: self.moc)
                }) {
                    Text(self.assignment.isComplete ? "Complete" : "Incomplete")
                        .foregroundColor(self.assignment.isComplete ? .green : .red)
                }
                Spacer()
            }
            .font(.subheadline)
            .padding(.horizontal)
            
            HStack {
                Text(self.assignment.details ?? "Unknown assignment details")
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showCourseDetail, content: {
            NavigationView {
                CourseDetailView(course: self.assignment.course ?? Course())
                    .environment(\.managedObjectContext, self.moc)
            }
        })
        .navigationBarTitle(self.assignment.name ?? "Unkown assignment")
            .navigationBarItems(trailing: Button(action: {
                self.showEdit.toggle()
            }, label: {
                Text("Edit")
            })
                .sheet(isPresented: $showEdit, content: {
                    EditAssignmentView(assignment: self.assignment)
                        .environment(\.managedObjectContext, self.moc)
                })
        )
    }
}

struct AssignmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AssignmentDetailView(assignment: Assignment())
        }
    }
}
