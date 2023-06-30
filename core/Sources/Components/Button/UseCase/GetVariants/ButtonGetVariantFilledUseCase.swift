//
//  ButtonGetVariantFilledUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonGetVariantFilledUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func colors(
        forIntentColor intentColor: ButtonIntentColor,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        switch intentColor {
        case .primary:
            return ButtonColorsDefault(
                foregroundColor: colors.primary.onPrimary,
                backgroundColor: colors.primary.primary,
                pressedBackgroundColor: colors.states.primaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return ButtonColorsDefault(
                foregroundColor: colors.secondary.onSecondary,
                backgroundColor: colors.secondary.secondary,
                pressedBackgroundColor: colors.states.secondaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.onNeutral,
                backgroundColor: colors.feedback.neutral,
                pressedBackgroundColor: colors.states.neutralPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.onAlert,
                backgroundColor: colors.feedback.alert,
                pressedBackgroundColor: colors.states.alertPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.onSuccess,
                backgroundColor: colors.feedback.success,
                pressedBackgroundColor: colors.states.successPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.onError,
                backgroundColor: colors.feedback.error,
                pressedBackgroundColor: colors.states.errorPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return ButtonColorsDefault(
                foregroundColor: colors.base.onSurface,
                backgroundColor: colors.base.surface,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
