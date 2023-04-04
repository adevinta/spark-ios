//
//  SparkTagIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

protocol SparkTagIntentColorsUseCaseable {
    func execute(for intentColor: SparkTagIntentColor,
                 on colors: Colors) -> SparkTagIntentColorables
}

struct SparkTagIntentColorsUseCase: SparkTagIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SparkTagIntentColor,
                 on colors: Colors) -> SparkTagIntentColorables {
        let surfaceColor = colors.base.surface

        switch intentColor {
        case .alert:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)

        case .danger:
            return SparkTagIntentColors(color: colors.feedback.error,
                                        onColor: colors.feedback.onError,
                                        containerColor: colors.feedback.errorContainer,
                                        onContainerColor: colors.feedback.onErrorContainer,
                                        surfaceColor: surfaceColor)

        case .info:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)

        case .neutral:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)

        case .primary:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)

        case .secondary:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)

        case .success:
            return SparkTagIntentColors(color: colors.feedback.alert,
                                        onColor: colors.feedback.onAlert,
                                        containerColor: colors.feedback.alertContainer,
                                        onContainerColor: colors.feedback.onAlertContainer,
                                        surfaceColor: surfaceColor)
        }
    }
}
