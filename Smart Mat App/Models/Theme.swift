import SwiftUI

enum Theme: String {
    case sand
    case pebble
    case slate
    case ash
    case mist
    case stone
    case clay
    case earth
    case dusk
    case taupe
    case smoke
    case cotton
    case ivory
    case linen
    case haze
    case driftwood
    case mushroom
    
    var accentColor: Color {
        switch self {
        case .sand, .pebble, .ash, .mist, .stone, .clay, .earth, .taupe, .cotton, .ivory, .linen, .haze, .driftwood, .mushroom:
            return  Color("LightBlue")
        case .slate, .dusk, .smoke:
            return .white
        }
    }
    
    var mainColor: Color {
        switch self {
        case .sand: return Color(red: 222/255, green: 184/255, blue: 135/255)      // Sandy Brown
        case .pebble: return Color(red: 176/255, green: 196/255, blue: 222/255)    // Light Steel Blue
        case .slate: return Color(red: 112/255, green: 128/255, blue: 144/255)     // Slate Gray
        case .ash: return Color(red: 178/255, green: 190/255, blue: 181/255)       // Ash Gray
        case .mist: return Color(red: 201/255, green: 226/255, blue: 233/255)      // Powder Blue
        case .stone: return Color(red: 140/255, green: 120/255, blue: 104/255)     // Dark Tan
        case .clay: return Color(red: 204/255, green: 132/255, blue: 67/255)       // Clay
        case .earth: return Color(red: 121/255, green: 85/255, blue: 72/255)       // Earth Brown
        case .dusk: return Color(red: 47/255, green: 79/255, blue: 79/255)         // Dark Slate Gray
        case .taupe: return Color(red: 150/255, green: 113/255, blue: 23/255)      // Taupe
        case .smoke: return Color(red: 96/255, green: 96/255, blue: 96/255)        // Dim Gray
        case .cotton: return Color(red: 240/255, green: 240/255, blue: 240/255)    // Light Gray
        case .ivory: return Color(red: 255/255, green: 255/255, blue: 240/255)     // Ivory
        case .linen: return Color(red: 250/255, green: 240/255, blue: 230/255)     // Linen
        case .haze: return Color(red: 224/255, green: 255/255, blue: 255/255)      // Light Cyan
        case .driftwood: return Color(red: 135/255, green: 115/255, blue: 91/255)  // Driftwood
        case .mushroom: return Color(red: 166/255, green: 123/255, blue: 91/255)   // Mushroom
        }
    }
    
    var name: String {
        return rawValue.capitalized
    }
}
