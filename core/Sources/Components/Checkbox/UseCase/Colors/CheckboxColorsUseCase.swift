//
//  CheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol CheckboxColorsUseCaseable {
    func execute(from color: Colors, intent: CheckboxIntent) -> CheckboxColors
}

struct CheckboxColorsUseCase: CheckboxColorsUseCaseable {

    func execute(from colors: Colors, intent: CheckboxIntent) -> CheckboxColors {
        switch intent {
        case .basic:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.basic.basic,
                iconColor: colors.basic.onBasic,
                pressedBorderColor: colors.basic.basicContainer
            )
        case .accent:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.accent.accent,
                iconColor: colors.accent.onAccent,
                pressedBorderColor: colors.accent.accentContainer
            )
        case .error:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.error,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.feedback.errorContainer
            )
        case .success:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.success,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.feedback.successContainer
            )
        case .alert:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.alert,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.feedback.alertContainer
            )
        case .info:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.info,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.feedback.infoContainer
            )
        case .neutral:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.neutral,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.feedback.neutralContainer
            )
        case .support:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.support.support,
                iconColor: colors.support.onSupport,
                pressedBorderColor: colors.support.supportContainer
            )
        case .main:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.main.main,
                iconColor: colors.main.onMain,
                pressedBorderColor: colors.main.mainContainer
            )
        }
    }
}
