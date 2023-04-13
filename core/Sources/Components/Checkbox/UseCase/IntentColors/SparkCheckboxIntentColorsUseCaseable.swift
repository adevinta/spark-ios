//
//  SparkTagIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkCheckboxIntentColorsUseCaseable {
    func execute(for intentColor: SparkSelectButtonState,
                 on colors: Colors) -> SparkCheckboxStateColorables
}

struct SparkCheckboxIntentColorsUseCase: SparkCheckboxIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SparkSelectButtonState,
                 on colors: Colors) -> SparkCheckboxStateColorables {
        let surfaceColor = colors.primary.primary
        let textColor = colors.base.onSurface
        let iconColor = colors.primary.onPrimary
        let pressedBorderColor = colors.primary.primaryContainer

        switch intentColor {
        case .enabled:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: surfaceColor,
            checkboxIconColor: iconColor,
            pressedBorderColor: pressedBorderColor)
        case .success:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.success,
            checkboxIconColor: iconColor,
            pressedBorderColor: pressedBorderColor)
        case .warning:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.alert,
            checkboxIconColor: iconColor,
            pressedBorderColor: pressedBorderColor)
        case .error:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.error,
            checkboxIconColor: iconColor,
            pressedBorderColor: pressedBorderColor)
        default:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: surfaceColor,
            checkboxIconColor: iconColor,
            pressedBorderColor: pressedBorderColor)
        }
    }
}
