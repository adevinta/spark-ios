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
        forIntentColor intentColor: ButtonIntentColor,
        colors: Colors,
        dims: Dims
    ) -> ButtonColorables {
        switch intentColor {
        case .primary:
            return ButtonColors(
                textColor: colors.primary.onPrimaryContainer,
                backgroundColor: colors.primary.primaryContainer,
                pressedBackgroundColor: colors.states.primaryContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .secondary:
            return ButtonColors(
                textColor: colors.secondary.onSecondaryContainer,
                backgroundColor: colors.secondary.secondaryContainer,
                pressedBackgroundColor: colors.states.secondaryContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .neutral:
            return ButtonColors(
                textColor: colors.feedback.onNeutralContainer,
                backgroundColor: colors.feedback.neutralContainer,
                pressedBackgroundColor: colors.states.neutralContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .alert:
            return ButtonColors(
                textColor: colors.feedback.onAlertContainer,
                backgroundColor: colors.feedback.alertContainer,
                pressedBackgroundColor: colors.states.alertContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .success:
            return ButtonColors(
                textColor: colors.feedback.onSuccessContainer,
                backgroundColor: colors.feedback.successContainer,
                pressedBackgroundColor: colors.states.successContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .danger:
            return ButtonColors(
                textColor: colors.feedback.onErrorContainer,
                backgroundColor: colors.feedback.errorContainer,
                pressedBackgroundColor: colors.states.errorContainerPressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .surface:
            return ButtonColors(
                textColor: colors.base.onBackgroundVariant,
                backgroundColor: colors.base.backgroundVariant,
                pressedBackgroundColor: colors.states.surfacePressed,
                borderColor: ColorTokenDefault.clear,
                pressedBorderColor: ColorTokenDefault.clear
            )
        }
    }
}
