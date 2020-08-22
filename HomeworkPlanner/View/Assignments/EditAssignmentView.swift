//
//  EditAssignmentView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/20/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct EditAssignmentView: View {
    @ObservedObject var assignment: Assignment
    @FetchRequest(entity: Course.entity(), sortDescriptors: []) var courses: FetchedResults<Course>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var updatedType: Int
    @State private var updatedPriority: Int
    @State private var updatedReminderTiming: Int
    
    @State private var errorMessage = ""
    @State private var showAlert = false
    
    let viewModel = EditAssignmentViewModel()
    @State private var initialDate: Date
    
    init(assignment: Assignment) {
        self.assignment = assignment
        self._updatedType = State(initialValue: Int(assignment.type))
        self._updatedPriority = State(initialValue: Int(assignment.priority))
        self._updatedReminderTiming = State(initialValue: Int(assignment.reminderTiming))
        self._initialDate = State(initialValue: assignment.dueDate ?? Date())
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: Binding($assignment.name)!)
                    TextView(placeholder: "Description", text: Binding($assignment.details)!)
                        .frame(height: 150)
                }
                
                Section {
                    Picker(selection: $updatedType, label: Text("Type")) {
                        ForEach(0..<AssignmentType.allCases.count, id: \.self) { index in
                            Text(AssignmentType.allCases[index].rawValue)
                        }
                    }
                    
                    Picker(selection: $updatedPriority, label: Text("Priority")) {
                        ForEach(0..<PriorityStates.allCases.count, id: \.self) { index in
                            HStack {
                                Text(PriorityStates.allCases[index].rawValue)
                                Image(systemName: Images.filledFlag)
                                    .foregroundColor(priorityColors[index])
                            }
                        }
                    }
                }
                
                Section {
                    DatePicker(selection: Binding($assignment.dueDate)!, in: Date()...) {
                        Text("Due date")
                    }
                    
                    Picker(selection: $updatedReminderTiming, label: Text("Reminder")) {
                        ForEach(0..<AssignmentReminderTiming.allCases.count, id: \.self) { index in
                            Text(AssignmentReminderTiming.allCases[index].rawValue)
                        }
                    }
                }
            }
            .navigationBarTitle("Edit assignment", displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(
                    action: {
                        self.moc.refresh(self.assignment, mergeChanges: false)
                        self.presentationMode.wrappedValue.dismiss()
                },
                    label: { Text("Cancel") }
                ),
                trailing:
                Button(
                    action: {
                        self.viewModel.save(assignment: self.assignment, initialDueDate: self.initialDate, updatedType: self.updatedType, updatedPriority: self.updatedPriority, updatedReminderTiming: self.updatedReminderTiming, context: self.moc) { (error) in
                            if let error = error {
                                self.errorMessage = error.rawValue
                                self.showAlert.toggle()
                            } else {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                },
                    label: { Text("Save") }
                )
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Oh no! 🥴"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
                    })
            )
        }
    }
}

struct EditAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        EditAssignmentView(assignment: Assignment())
    }
}
