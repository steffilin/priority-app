//
//  TextEditorWithPlaceholder.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/18/22.
//

import Foundation
import SwiftUI

//specific for Description box with placeholder "Description"

struct TextEditorWithPlaceholder: View {
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
               
                Text("Description")
                    .padding(.top, 10.0)
                    .padding(.leading, 5)
                    .foregroundColor(.gray)
                    .opacity(0.7)
                    .frame(width: 318.0 - 28, height: 251.0 - 28, alignment: .topLeading)
                   
               
            }
            
            
            TextEditor(text: $text)
//                .opacity(text.isEmpty ? 0.85 : 1)
                .scrollContentBackground(Visibility.hidden)
                .frame(width: 318.0 - 28, height: 251.0 - 28, alignment: .top)
                
          
            
        }
    }
}
