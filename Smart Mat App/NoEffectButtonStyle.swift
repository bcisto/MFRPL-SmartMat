//
//  NoOpacityChangeButtonStyle.swift
//  Smart Mat App
//
//  Created by Brian Cisto on 7/20/24.
//

import SwiftUI

struct NoEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.0 : 1.0) // No scale change
            .brightness(configuration.isPressed ? 0.0 : 0.0) // No brightness change
            .opacity(configuration.isPressed ? 1.0 : 1.0)
    }
}
