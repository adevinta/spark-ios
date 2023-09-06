//
//  CheckboxGetStateColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol CheckboxGetStateColorsUseCaseable {
    func execute(for state: SelectButtonState,
                 from colors: Colors) -> CheckboxStateColorables
}

struct CheckboxGetStateColorsUseCase: CheckboxGetStateColorsUseCaseable {

    // MARK: - Methods

    func execute(for state: SelectButtonState,
                 from colors: Colors) -> CheckboxStateColorables {
        let surfaceColor = colors.main.main
        let textColor = colors.base.onSurface
        let iconColor = colors.main.onMain
        let pressedBorderColor = colors.main.mainContainer

        switch state {
        case .enabled:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: surfaceColor,
                checkboxIconColor: iconColor,
                pressedBorderColor: pressedBorderColor
            )
        case .success:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: colors.feedback.success,
                checkboxIconColor: iconColor,
                pressedBorderColor: colors.feedback.successContainer
            )
        case .accent:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: colors.accent.accent,
                checkboxIconColor: iconColor,
                pressedBorderColor: colors.accent.accentContainer
            )
        case .basic:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: colors.basic.basic,
                checkboxIconColor: iconColor,
                pressedBorderColor: colors.basic.basicContainer
            )
        case .warning:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: colors.feedback.alert,
                checkboxIconColor: iconColor,
                pressedBorderColor: colors.feedback.alertContainer
            )
        case .error:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: colors.feedback.error,
                checkboxIconColor: iconColor,
                pressedBorderColor: colors.feedback.errorContainer
            )
        default:
            return CheckboxStateColors(
                textColor: textColor,
                checkboxColor: surfaceColor,
                checkboxIconColor: iconColor,
                pressedBorderColor: pressedBorderColor
            )
        }
    }
}
