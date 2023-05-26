//
//  SparkTagIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol CheckboxStateColorsUseCaseable {
    func execute(for intentColor: SelectButtonState,
                 on colors: Colors) -> CheckboxStateColorables
}

struct CheckboxStateColorsUseCase: CheckboxStateColorsUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SelectButtonState,
                 on colors: Colors) -> CheckboxStateColorables {
        let surfaceColor = colors.primary.primary
        let textColor = colors.base.onSurface
        let iconColor = colors.primary.onPrimary
        let pressedBorderColor = colors.primary.primaryContainer

        switch intentColor {
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
