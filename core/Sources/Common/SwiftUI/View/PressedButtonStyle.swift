//
//  PressedButtonStyle.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 04.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed != self.isPressed {
                    self.isPressed = isPressed
                }
            }
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
