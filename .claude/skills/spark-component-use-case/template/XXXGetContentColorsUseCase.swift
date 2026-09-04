//
//  XXXGetContentColorsUseCase.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkTheming

// sourcery: AutoMockable, AutoMockTest
protocol XXXGetContentColorsUseCaseable {
    // sourcery: theme = "Identical"
    func execute(
        theme: any Theme,
        intent: XXXIntent,
        isSelected: Bool,
        isPressed: Bool
    ) -> XXXContentColors
}

struct XXXGetContentColorsUseCase: XXXGetContentColorsUseCaseable {

    // MARK: - Methods

    func execute(
        theme: any Theme,
        intent: XXXIntent,
        isSelected: Bool,
        isPressed: Bool
    ) -> XXXContentColors {
        let colors = theme.colors

        let backgroundColorToken: any ColorToken = if isPressed {
            colors.states.surfacePressed
        } else {
            ColorTokenClear()
        }

        let tintColorToken: any ColorToken = if !isSelected {
            colors.base.onSurface
        } else {
            switch intent {
            case .main: colors.main.main
            case .support: colors.support.support
            }
        }

        return XXXContentColors(
            tintColorToken: tintColorToken,
            backgroundColorToken: backgroundColorToken
        )
    }
}
