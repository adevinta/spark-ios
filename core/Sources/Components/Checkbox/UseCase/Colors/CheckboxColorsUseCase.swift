//
//  CheckboxColorsUseCase.swift
//  Spark
//
//  Created by janniklas.freundt.ext on 04.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol CheckboxColorsUseCaseable {
    func execute(from color: Colors, intent: CheckboxIntent) -> CheckboxColors
}

struct CheckboxColorsUseCase: CheckboxColorsUseCaseable {

    // MARK: - Methods
    func execute(from colors: Colors, intent: CheckboxIntent) -> CheckboxColors {
        switch intent {
        case .basic:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.basic.basic,
                iconColor: colors.basic.onBasic,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .accent:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.accent.onAccent,
                iconColor: colors.accent.onAccent,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .error:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.error,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .success:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.success,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .alert:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.alert,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .info:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.info,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .neutral:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.feedback.neutral,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .support:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.support.support,
                iconColor: colors.support.onSupport,
                pressedBorderColor: ColorTokenDefault.clear
            )
        case .main:
            return CheckboxColors(
                textColor: colors.base.onSurface,
                borderColor: colors.base.outline,
                tintColor: colors.main.main,
                iconColor: colors.main.onMain,
                pressedBorderColor: ColorTokenDefault.clear
            )
        }
    }
}
