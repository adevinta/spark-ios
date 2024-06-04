//
//  ButtonGetVariantTintedUseCase.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

struct ButtonGetVariantTintedUseCase: ButtonGetVariantUseCaseable {

    // MARK: - Methods

    func execute(
        intent: ButtonIntent,
        colors: Colors,
        dims: Dims
    ) -> ButtonColors {
        let borderColor = ColorTokenDefault.clear
        let pressedBorderColor = ColorTokenDefault.clear

        switch intent {
        case .accent:
            return .init(
                foregroundColor: colors.accent.onAccentContainer,
                backgroundColor: colors.accent.accentContainer,
                pressedBackgroundColor: colors.states.accentContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .basic:
            return .init(
                foregroundColor: colors.basic.onBasicContainer,
                backgroundColor: colors.basic.basicContainer,
                pressedBackgroundColor: colors.states.accentContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .main:
            return .init(
                foregroundColor: colors.main.onMainContainer,
                backgroundColor: colors.main.mainContainer,
                pressedBackgroundColor: colors.states.mainContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        case .support:
            return .init(
                foregroundColor: colors.support.onSupportContainer,
                backgroundColor: colors.support.supportContainer,
                pressedBackgroundColor: colors.states.supportContainerPressed,
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
        case .info:
            return .init(
                foregroundColor: colors.feedback.onInfoContainer,
                backgroundColor: colors.feedback.infoContainer,
                pressedBackgroundColor: colors.states.infoContainerPressed,
                borderColor: borderColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
