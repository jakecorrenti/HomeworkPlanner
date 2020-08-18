//
//  ImageWithLabelView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/17/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct ImageWithLabelView: View {
    var image: Image
    var label: String
    var hasSpacer: Bool = false 
    var font: Font = .caption
    
    var body: some View {
        HStack {
            image
            Text(label)
                .foregroundColor(.secondary)
            if hasSpacer {
                Spacer()
            }
        }
        .font(font)
    }
}

struct ImageWithLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ImageWithLabelView(image: Image(systemName: Images.book), label: "Book", hasSpacer: false)
    }
}
