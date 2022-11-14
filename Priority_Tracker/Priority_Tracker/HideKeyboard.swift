//
//  HideKeyboard.swift
//  Priority_Tracker
//
//  Created by Steffi Lin on 11/14/22.
//

import Foundation

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

