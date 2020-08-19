//
//  NewCourseView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct NewCourseView: View {
    @State private var name = ""
    @State private var professor = ""
    @State private var location = ""
    @State private var type = 0
    @State private var startTime = Date()
    @State private var endTime = Date().advanced(by: 60)
    @State private var frequency = [Int]()
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    private var viewModel = NewCourseViewModel()
    
    init() {
        UITableView.appearance().keyboardDismissMode = .onDrag
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                    TextField("Professor", text: $professor)
                    TextField("Location", text: $location)
                }
                
                Section {
                    Picker(selection: $type, label: Text("Type")) {
                        ForEach(0..<CourseType.allCases.count, id: \.self) { index in
                            Text(CourseType.allCases[index].rawValue)
                        }
                    }
                    NavigationLink(destination: CourseFrequencyView(frequency: $frequency)) {
                        HStack {
                            Text("Frequency")
                            Spacer()
                            Text("\(self.frequency.count) \(self.frequency.count == 1 ? "day" : "days")")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section{
                    DatePicker(selection: $startTime, displayedComponents: .hourAndMinute) {
                        Text("Start time")
                    }
                    DatePicker(selection: $endTime, displayedComponents: .hourAndMinute) {
                        Text("End time")
                    }
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Oh no! 🥴"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
            })
            .navigationBarTitle("New course", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(
                    action: {
                        self.viewModel.saveCourse(context: self.moc, name: self.name, professor: self.professor, location: self.location, type: self.type, frequency: self.frequency, startTime: self.startTime, endTime: self.endTime) { (result) in
                            switch result {
                            case .failure(let error):
                                self.errorMessage = error.rawValue
                                self.showAlert.toggle()
                            case .success(_):
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

struct NewCourseView_Previews: PreviewProvider {
    static var previews: some View {
        NewCourseView()
    }
}
