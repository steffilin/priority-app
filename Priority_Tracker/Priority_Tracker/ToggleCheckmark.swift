//
//  ToggleCheckmark.swift
//  Priority_Tracker
//
//  Created by Steffi Lin on 11/11/22.
//

import SwiftUI

struct ToggleCheckmark: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
     
            return HStack {
     
     
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.accentColor)
                    .background(configuration.isOn ? .clear : .bg_gray)
                    .font(.system(size: 25, weight: .bold, design: .default))
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
     
        }
    }
