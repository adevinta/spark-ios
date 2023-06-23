//
//  ButtonVariantGetContrastUseCase.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonVariantGetContrastUseCase: ButtonGetVariantUseCaseable {

struct ButtonVariantGetContrastUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func colors(
        forIntentColor intentColor: ButtonIntentColor,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear
        let backgroundColor = colors.base.surface

        switch intentColor {
        case .primary:
            return ButtonColorsDefault(
                foregroundColor: colors.primary.primary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.primaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return ButtonColorsDefault(
                foregroundColor: colors.secondary.secondary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.secondaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.neutral,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.neutralContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.alert,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.alertContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.success,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.successContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return ButtonColorsDefault(
                foregroundColor: colors.feedback.error,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.errorContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return ButtonColorsDefault(
                foregroundColor: colors.base.onSurface,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
