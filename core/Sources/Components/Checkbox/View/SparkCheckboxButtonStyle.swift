//
//  SparkCheckboxButtonStyle.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct SparkCheckboxButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    init(isPressed: Binding<Bool>) {
        _isPressed = isPressed
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed != isPressed {
            DispatchQueue.main.async {
                isPressed = configuration.isPressed
            }
        }

        return configuration.label
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
