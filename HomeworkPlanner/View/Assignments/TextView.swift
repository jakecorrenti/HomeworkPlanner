//
//  TextView.swift
//  HomeworkPlanner
//
//  Created by Jake Correnti on 8/19/20.
//  Copyright © 2020 Jake Correnti. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    
    // resource used to get the coordinator and placeholder working: https://www.youtube.com/watch?v=2wwSaPNxS3I
    
    var placeholder: String
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.text = placeholder
        textView.textColor = .placeholderText
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        
        if text != "" || uiView.textColor == .label {
            uiView.text = text
            uiView.textColor = .label
        }
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> TextView.Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText {
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholder
                textView.textColor = .placeholderText
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(placeholder: "Description", text: Binding<String>.constant("HEY"))
    }
}
