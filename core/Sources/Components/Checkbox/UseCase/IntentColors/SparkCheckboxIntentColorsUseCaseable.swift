//
//  SparkTagIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkCheckboxIntentColorsUseCaseable {
    func execute(for intentColor: SparkCheckboxState,
                 on colors: Colors) -> SparkCheckboxStateColorables
}

struct SparkCheckboxIntentColorsUseCase: SparkCheckboxIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SparkCheckboxState,
                 on colors: Colors) -> SparkCheckboxStateColorables {
        let surfaceColor = colors.base.surface
        let textColor = colors.base.onSurface
        let iconColor = colors.primary.onPrimary

        switch intentColor {
        case .enabled:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: surfaceColor,
            checkboxIconColor: iconColor)
        case .success:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.success,
            checkboxIconColor: iconColor)
        case .warning:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.neutral,
            checkboxIconColor: iconColor)
        case .error:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: colors.feedback.error,
            checkboxIconColor: iconColor)
        default:
            return SparkCheckboxStateColors(textColor: textColor,
                                             checkboxColor: surfaceColor,
            checkboxIconColor: iconColor)
        }
    }
}
