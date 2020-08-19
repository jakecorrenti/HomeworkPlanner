//
//  EditCourseView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct EditCourseView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var course: Course
    @State private var updatedType: Int
    @State private var showAlert = false
    @State private var errorMessage = ""

    private var viewModel = EditCourseViewModel()

    init(course: Course) {
        self.course = course
        self._updatedType = State(initialValue: Int(course.type))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: Binding($course.name)!)
                    TextField("Professor", text: Binding($course.professor)!)
                    TextField("Location", text: Binding($course.location)!)
                }

                Section {
                    Picker(selection: $updatedType, label: Text("Type")) {
                        ForEach(0..<CourseType.allCases.count, id: \.self) { index in
                            Text(CourseType.allCases[index].rawValue)
                        }
                    }
                    NavigationLink(destination: CourseFrequencyView(frequency: Binding($course.frequency)!)) {
                        HStack {
                            Text("Frequency")
                            Spacer()
                            Text("\(self.course.frequency!.count) \(self.course.frequency!.count == 1 ? "day" : "days")")
                                .foregroundColor(.secondary)
                        }
                    }
                }

                Section {
                    DatePicker(selection: Binding($course.start)!, displayedComponents: .hourAndMinute) {
                        Text("Start time")
                    }
                    DatePicker(selection: Binding($course.end)!, displayedComponents: .hourAndMinute) {
                        Text("End time")
                    }
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Oh no! 🥴"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
            })
            .navigationBarTitle(Text("Edit course"), displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(
                    action: {
                        self.moc.refresh(self.course, mergeChanges: false)
                        self.presentationMode.wrappedValue.dismiss()
                },
                    label: { Text("Cancel") }
                ),
                trailing:
                Button(
                    action: {
                        self.viewModel.save(course: self.course, updatedType: self.updatedType, context: self.moc) { (error) in
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
            )
        }
    }
}

struct EditCourseView_Previews: PreviewProvider {
    static var previews: some View {
        EditCourseView(course: Course())
    }
}
