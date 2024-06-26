//
//  RatingGetColorUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 09.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol RatingGetColorsUseCaseable {
    func execute(theme: Theme,
                 intent: RatingIntent,
                 state: RatingState
    ) -> RatingColors
}

extension RatingGetColorsUseCaseable {
    func execute(theme: Theme,
                 intent: RatingIntent
    ) -> RatingColors {
        return self.execute(theme: theme, intent: intent, state: .standard)
    }
}

/// Get the colors of the rating
struct RatingGetColorsUseCase: RatingGetColorsUseCaseable {

    /// Returns the rating colors.
    ///
    /// - Parameters:
    ///   - theme: the current theme
    ///   - intent: the intent defining the color in the theme
    ///   - state: the current state
    func execute(theme: Theme,
                 intent: RatingIntent,
                 state: RatingState
    ) -> RatingColors {

        var colors: RatingColors
        let fillColor = state.isPressed ? theme.colors.states.mainVariantPressed : theme.colors.main.mainVariant

        switch intent {
            case .main: colors = RatingColors(
                fillColor: fillColor,
                strokeColor: theme.colors.base.onSurface.opacity(theme.dims.dim3),
                opacity: theme.dims.none
            )
        }

        if !state.isEnabled {
            colors.opacity = theme.dims.dim3
        }
        return colors
    }

}
