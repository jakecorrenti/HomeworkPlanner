//
//  CourseDetailFrequencyView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/18/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseDetailFrequencyView: View {
    var frequency: [Int]
    
    var body: some View {
        VStack {
            HStack {
                Text("Frequency")
                    .foregroundColor(.secondary)
                Spacer()
            }
            HStack(spacing: 16){
                ForEach(0..<daysInitials.count, id: \.self) { index in
                    ZStack {
                        Circle()
                            .foregroundColor(self.frequency.contains(index) ? .accentColor : Color(UIColor.secondarySystemBackground))
                            .frame(width: 35, height: 35)
                        Text(daysInitials[index].uppercased())
                            .bold()
                            .foregroundColor(self.frequency.contains(index) ? .white : .primary)
                    }
                }
            }
        }
    }
}

struct CourseDetailFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetailFrequencyView(frequency: [0, 4, 6, 7])
            
    }
}
