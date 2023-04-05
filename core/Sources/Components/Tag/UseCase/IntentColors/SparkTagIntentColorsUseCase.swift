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
            return SparkTagIntentColors(color: colors.feedback.info,
                                        onColor: colors.feedback.onInfo,
                                        containerColor: colors.feedback.infoContainer,
                                        onContainerColor: colors.feedback.onInfoContainer,
                                        surfaceColor: surfaceColor)

        case .neutral:
            return SparkTagIntentColors(color: colors.feedback.neutral,
                                        onColor: colors.feedback.onNeutral,
                                        containerColor: colors.feedback.neutralContainer,
                                        onContainerColor: colors.feedback.onNeutralContainer,
                                        surfaceColor: surfaceColor)

        case .primary:
            return SparkTagIntentColors(color: colors.primary.primary,
                                        onColor: colors.primary.onPrimary,
                                        containerColor: colors.primary.primaryContainer,
                                        onContainerColor: colors.primary.onPrimaryContainer,
                                        surfaceColor: surfaceColor)

        case .secondary:
            return SparkTagIntentColors(color: colors.secondary.secondary,
                                        onColor: colors.secondary.onSecondary,
                                        containerColor: colors.secondary.secondaryContainer,
                                        onContainerColor: colors.secondary.onSecondaryContainer,
                                        surfaceColor: surfaceColor)

        case .success:
            return SparkTagIntentColors(color: colors.feedback.success,
                                        onColor: colors.feedback.onSuccess,
                                        containerColor: colors.feedback.successContainer,
                                        onContainerColor: colors.feedback.onSuccessContainer,
                                        surfaceColor: surfaceColor)
        }
    }
}
