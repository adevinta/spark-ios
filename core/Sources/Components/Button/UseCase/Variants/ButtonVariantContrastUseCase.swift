//
//  ButtonVariantContrastUseCase.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonVariantContrastUseCase: ButtonVariantUseCaseable {

    // MARK: - Methods

    func colors(
        for intentColor: ButtonIntentColor,
        on colors: Colors,
        dims: Dims
    ) -> ButtonColorables {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear
        let backgroundColor = colors.base.surface

        switch intentColor {
        case .primary:
            return ButtonColors(
                textColor: colors.primary.primary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.primaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return ButtonColors(
                textColor: colors.secondary.secondary,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.secondaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return ButtonColors(
                textColor: colors.feedback.neutral,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.neutralContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return ButtonColors(
                textColor: colors.feedback.alert,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.alertContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return ButtonColors(
                textColor: colors.feedback.success,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.successContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return ButtonColors(
                textColor: colors.feedback.error,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.errorContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return ButtonColors(
                textColor: colors.base.onSurface,
                backgroundColor: backgroundColor,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
