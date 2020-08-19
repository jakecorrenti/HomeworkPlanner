//
//  NewAssignmentView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct NewAssignmentView: View {
    
    @State private var name = ""
    @State private var details = ""
    @State private var type = 0
    @State private var dueDate = Date().addingTimeInterval(900)
    @State private var reminderTiming = 0
    @State private var priority = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextView(placeholder: "Description", text: $details)
                        .frame(height: 150)
                }
                
                Section {
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
                    
                    Picker(selection: $reminderTiming, label: Text("Reminder timing")) {
                        ForEach(0..<AssignmentReminderTiming.allCases.count, id: \.self) { index in
                            Text(AssignmentReminderTiming.allCases[index].rawValue)
                        }
                    }
                }
            }
            .navigationBarTitle("New assignment", displayMode: .inline)
        }
    }
}

struct NewAssignmentView_Previews: PreviewProvider {
    static var previews: some View {
        NewAssignmentView()
    }
}
