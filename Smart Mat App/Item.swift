//
//  Item.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 7/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
