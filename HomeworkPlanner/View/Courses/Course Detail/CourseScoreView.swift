//
//  CourseScoreView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/23/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct AssignmentScoreView: View {
    var body: some View {
        VStack {
            Text("Score:")
                .font(.footnote)
                .foregroundColor(.secondary)
            Text("AWESOME!")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.top, 8)
            Text("98%")
                .font(.largeTitle)
                .bold()
        }
    }
}

struct CourseScoreView_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentScoreView()
    }
}
