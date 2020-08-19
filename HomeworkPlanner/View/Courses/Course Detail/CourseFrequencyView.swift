//
//  CourseFrequencyView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct CourseFrequencyView: View {
    @Binding var frequency: [Int]
    
    var body: some View {
        List(0..<Days.allCases.count, id: \.self) { index in
            HStack {
                Text(Days.allCases[index].rawValue)
                Spacer()
                if self.frequency.contains(index) {
                    Image(systemName: Images.checkmark)
                        .foregroundColor(.accentColor)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if self.frequency.contains(index) {
                    self.frequency.remove(at: self.frequency.firstIndex(of: index)!)
                } else {
                    self.frequency.append(index)
                }
            }
            .padding(.horizontal)
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Frequency", displayMode: .inline)
    }
}

struct CourseFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        CourseFrequencyView(frequency: Binding.constant([1, 4, 7]))
    }
}
