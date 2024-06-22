//
//  Theme.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 6/21/24.
//

import SwiftUI


enum Theme: String {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    var mainColor: Color {
        switch self {
            case .bubblegum: return .pink
            case .buttercup: return .yellow
            case .indigo: return .blue
            case .lavender: return .purple
            case .magenta: return .pink
            case .navy: return .blue
            case .oxblood: return .red
            case .periwinkle: return .blue
            case .poppy: return .red
            case .purple: return .purple
            case .seafoam: return .green
            case .sky: return .blue
            case .tan: return .brown
            case .teal: return .blue
            case .yellow: return .yellow
            case .orange: return .orange
        }
    }
    var name: String {
        return rawValue.capitalized
    }
}
