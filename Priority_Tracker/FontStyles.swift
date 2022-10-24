//
//  FontStyles.swift
//  Priority Tracker
//
//  Created by Steffi Lin on 10/17/22.
//

import Foundation

import SwiftUI

extension Font {
    static var mainTitle: Font {
        return Font.custom("SFProDisplay-Heavy", size: 38)
    }
    
    static var buttonText: Font {
        return Font.custom("SFProDisplay-Heavy", size: 25)
    }
    
    static var normalText: Font {
        return Font.custom("SF-Pro-Text-Thin", size: 17)
    }
    
}
