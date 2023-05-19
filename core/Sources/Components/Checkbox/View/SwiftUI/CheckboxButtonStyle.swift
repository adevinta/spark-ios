//
//  CheckboxButtonStyle.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 12.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI

struct CheckboxButtonStyle: ButtonStyle {
    // MARK: - Properties

    @Binding var isPressed: Bool

    // MARK: - Initialization

    init(isPressed: Binding<Bool>) {
        self._isPressed = isPressed
    }

    // MARK: - Methods

    func makeBody(configuration: Self.Configuration) -> some View {
        if configuration.isPressed != self.isPressed {
            DispatchQueue.main.async {
                self.isPressed = configuration.isPressed
            }
        }

        return configuration.label
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
