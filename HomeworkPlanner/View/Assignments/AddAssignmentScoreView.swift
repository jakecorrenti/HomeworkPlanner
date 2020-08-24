//
//  AddAssignmentScoreView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/24/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AddAssignmentScoreView: View {
    @State private var score = ""
    @State private var showAlert = false
    @State private var errorMessage = ""
    
    @ObservedObject var assignment: Assignment
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                    .frame(height: 24)
                Text("What grade did you get on *Assignment name*?")
                    .multilineTextAlignment(.center)
                TextField("Score", text: $score)
                    .keyboardType(.decimalPad)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .navigationBarTitle("Assignment score", displayMode: .inline)
            .navigationBarItems(
                leading:
                Button(
                    action: {
                        self.presentationMode.wrappedValue.dismiss()
                },
                    label: { Text("Cancel") }
                ),
                trailing:
                Button(
                    action: {
                        self.assignment.score = Double(self.score) ?? 0.0
                        
                        do {
                            try self.moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                        } catch {
                            self.moc.refresh(self.assignment, mergeChanges: false)
                            self.errorMessage = error.localizedDescription
                            self.showAlert.toggle()
                        }
                        
                },
                    label: { Text("Save") }
                )
            )
        }
    }
}

struct AddAssignmentScoreView_Previews: PreviewProvider {
    static var previews: some View {
        AddAssignmentScoreView(assignment: Assignment())
    }
}
