//
//  NewAssignmentViewSpecifyingCourse.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/22/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct NewAssignmentViewSpecifyingCourse: View {
    
    @FetchRequest(entity: Course.entity(), sortDescriptors: []) var courses: FetchedResults<Course>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var details = ""
    @State private var course = 0
    @State private var type = 0
    @State private var priority = 0
    @State private var dueDate = Date().addingTimeInterval(60)
    @State private var reminderTiming = 0
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    let viewModel = NewAssignmentViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextView(placeholder: "Description", text: $details)
                        .frame(height: 150)
                }
                
                Section {
                    Picker(selection: $course, label: Text("Course")) {
                        ForEach(0..<self.courses.count, id: \.self) { index in
                            Text(self.courses[index].name ?? "Unknown course")
                        }
                    }
                    
                    Picker(selection: $type, label: Text("Type")) {
                        ForEach(0..<AssignmentType.allCases.count, id: \.self) { index in
                            Text(AssignmentType.allCases[index].rawValue)
                        }
                    }
                    
                    Picker(selection: $priority, label: Text("Priority")) {
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
                    DatePicker(selection: $dueDate) {
                        Text("Due date")
                    }
                    
                    Picker(selection: $reminderTiming, label: Text("Reminder")) {
                        ForEach(0..<AssignmentReminderTiming.allCases.count, id: \.self) { index in
                            Text(AssignmentReminderTiming.allCases[index].rawValue)
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert, content: { () -> Alert in
                Alert(title: Text("Oh no! 🥴"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
            })
                .navigationBarTitle("New assignment", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(
                        action: {
                            self.viewModel.save(course: self.courses[self.course], name: self.name, details: self.details, type: self.type, priority: self.priority, dueDate: self.dueDate, reminderTiming: self.reminderTiming, context: self.moc) { (error) in
                                if let error = error {
                                    self.errorMessage = error.rawValue
                                    self.showAlert.toggle()
                                } else {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                    },
                        label: { Text("Add").bold() }
                    )
            )
        }
    }
}

struct NewAssignmentViewSpecifyingCourse_Previews: PreviewProvider {
    static var previews: some View {
        NewAssignmentViewSpecifyingCourse()
    }
}
