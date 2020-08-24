//
//  AssignmentScoreView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/23/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentScoreView: View {
    let viewModel = AssignmentDetailViewModel()
    let score = 87.00
    var body: some View {
        VStack {
            Text("Score:")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text(self.viewModel.determineScoreMessage(score: self.score))
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 8)
                .foregroundColor(self.viewModel.determineScoreColor(score: self.score))
            Text(String(format: "%.2f", self.score) + "%")
                .font(.title)
                .bold()
                .foregroundColor(self.viewModel.determineScoreColor(score: self.score))
        }
    }
}

struct CourseScoreView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentScoreView()
    }
}
