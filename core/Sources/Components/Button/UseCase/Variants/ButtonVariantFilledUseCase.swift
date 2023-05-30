//
//  ButtonVariantFilledUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonVariantFilledUseCase: ButtonVariantUseCaseable {

    // MARK: - Methods

    func colors(
        for intentColor: ButtonIntentColor,
        on colors: Colors,
        dims: Dims
    ) -> ButtonColorables {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        switch intentColor {
        case .primary:
            return ButtonColors(
                textColor: colors.primary.onPrimary,
                backgroundColor: colors.primary.primary,
                pressedBackgroundColor: colors.states.primaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return ButtonColors(
                textColor: colors.secondary.onSecondary,
                backgroundColor: colors.secondary.secondary,
                pressedBackgroundColor: colors.states.secondaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return ButtonColors(
                textColor: colors.feedback.onNeutral,
                backgroundColor: colors.feedback.neutral,
                pressedBackgroundColor: colors.states.neutralPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return ButtonColors(
                textColor: colors.feedback.onAlert,
                backgroundColor: colors.feedback.alert,
                pressedBackgroundColor: colors.states.alertPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return ButtonColors(
                textColor: colors.feedback.onSuccess,
                backgroundColor: colors.feedback.success,
                pressedBackgroundColor: colors.states.successPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return ButtonColors(
                textColor: colors.feedback.onError,
                backgroundColor: colors.feedback.error,
                pressedBackgroundColor: colors.states.errorPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return ButtonColors(
                textColor: colors.base.onSurface,
                backgroundColor: colors.base.surface,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
