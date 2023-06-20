//
//  TagGetIntentColorsUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagGetIntentColorsUseCaseable {
    func execute(forIntentColor intentColor: TagIntentColor,
                 colors: Colors) -> TagIntentColorables
}

struct TagGetIntentColorsUseCase: TagGetIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(forIntentColor intentColor: TagIntentColor,
                 colors: Colors) -> TagIntentColorables {
        let surfaceColor = colors.base.surface

        switch intentColor {
        case .alert:
            return TagIntentColors(
                color: colors.feedback.alert,
                onColor: colors.feedback.onAlert,
                containerColor: colors.feedback.alertContainer,
                onContainerColor: colors.feedback.onAlertContainer,
                surfaceColor: surfaceColor
            )

        case .danger:
            return TagIntentColors(
                color: colors.feedback.error,
                onColor: colors.feedback.onError,
                containerColor: colors.feedback.errorContainer,
                onContainerColor: colors.feedback.onErrorContainer,
                surfaceColor: surfaceColor
            )

        case .info:
            return TagIntentColors(
                color: colors.feedback.info,
                onColor: colors.feedback.onInfo,
                containerColor: colors.feedback.infoContainer,
                onContainerColor: colors.feedback.onInfoContainer,
                surfaceColor: surfaceColor
            )

        case .neutral:
            return TagIntentColors(
                color: colors.feedback.neutral,
                onColor: colors.feedback.onNeutral,
                containerColor: colors.feedback.neutralContainer,
                onContainerColor: colors.feedback.onNeutralContainer,
                surfaceColor: surfaceColor
            )

        case .primary:
            return TagIntentColors(
                color: colors.primary.primary,
                onColor: colors.primary.onPrimary,
                containerColor: colors.primary.primaryContainer,
                onContainerColor: colors.primary.onPrimaryContainer,
                surfaceColor: surfaceColor
            )

        case .secondary:
            return TagIntentColors(
                color: colors.secondary.secondary,
                onColor: colors.secondary.onSecondary,
                containerColor: colors.secondary.secondaryContainer,
                onContainerColor: colors.secondary.onSecondaryContainer,
                surfaceColor: surfaceColor
            )

        case .success:
            return TagIntentColors(
                color: colors.feedback.success,
                onColor: colors.feedback.onSuccess,
                containerColor: colors.feedback.successContainer,
                onContainerColor: colors.feedback.onSuccessContainer,
                surfaceColor: surfaceColor
            )
        }
    }
}
