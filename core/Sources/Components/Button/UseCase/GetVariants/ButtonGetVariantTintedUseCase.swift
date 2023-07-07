//
//  ButtonGetVariantTintedUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

struct ButtonGetVariantTintedUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func colors(
        for intent: ButtonIntent,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        switch intent {
        case .primary:
            return .init(
                foregroundColor: colors.primary.onPrimaryContainer,
                backgroundColor: colors.primary.primaryContainer,
                pressedBackgroundColor: colors.states.primaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return .init(
                foregroundColor: colors.secondary.onSecondaryContainer,
                backgroundColor: colors.secondary.secondaryContainer,
                pressedBackgroundColor: colors.states.secondaryContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return .init(
                foregroundColor: colors.feedback.onNeutralContainer,
                backgroundColor: colors.feedback.neutralContainer,
                pressedBackgroundColor: colors.states.neutralContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return .init(
                foregroundColor: colors.feedback.onAlertContainer,
                backgroundColor: colors.feedback.alertContainer,
                pressedBackgroundColor: colors.states.alertContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return .init(
                foregroundColor: colors.feedback.onSuccessContainer,
                backgroundColor: colors.feedback.successContainer,
                pressedBackgroundColor: colors.states.successContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return .init(
                foregroundColor: colors.feedback.onErrorContainer,
                backgroundColor: colors.feedback.errorContainer,
                pressedBackgroundColor: colors.states.errorContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return .init(
                foregroundColor: colors.base.onBackgroundVariant,
                backgroundColor: colors.base.backgroundVariant,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
