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

    func execute(
        for intent: ButtonIntent,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        switch intent {
        case .primary:
            return .init(
                foregroundColor: colors.primary.onPrimary,
                backgroundColor: colors.primary.primary,
                pressedBackgroundColor: colors.states.primaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .secondary:
            return .init(
                foregroundColor: colors.secondary.onSecondary,
                backgroundColor: colors.secondary.secondary,
                pressedBackgroundColor: colors.states.secondaryPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .neutral:
            return .init(
                foregroundColor: colors.feedback.onNeutral,
                backgroundColor: colors.feedback.neutral,
                pressedBackgroundColor: colors.states.neutralPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .alert:
            return .init(
                foregroundColor: colors.feedback.onAlert,
                backgroundColor: colors.feedback.alert,
                pressedBackgroundColor: colors.states.alertPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return .init(
                foregroundColor: colors.feedback.onSuccess,
                backgroundColor: colors.feedback.success,
                pressedBackgroundColor: colors.states.successPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .danger:
            return .init(
                foregroundColor: colors.feedback.onError,
                backgroundColor: colors.feedback.error,
                pressedBackgroundColor: colors.states.errorPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .surface:
            return .init(
                foregroundColor: colors.base.onSurface,
                backgroundColor: colors.base.surface,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
