//
//  GetChipIntentColorsUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol GetChipIntentColorsUseCasable {
    func execute(colors: Colors, intentColor: ChipIntentColor) -> ChipIntentColors
}

struct GetChipIntentColorsUseCase: GetChipIntentColorsUseCasable {
    func execute(colors: Colors, intentColor: ChipIntentColor) -> ChipIntentColors {
        switch intentColor {
        case .primary:
            return .init(primary: colors.primary.primary,
                         secondary: colors.primary.onPrimary,
                         tintedPrimary: colors.primary.primaryContainer,
                         tintedSecondary: colors.primary.onPrimaryContainer)
        case .secondary:
            return .init(primary: colors.secondary.secondary,
                         secondary: colors.secondary.onSecondary,
                         tintedPrimary: colors.secondary.secondaryContainer,
                         tintedSecondary: colors.secondary.onSecondaryContainer)
        case .surface:
            return .init(primary: colors.base.surface,
                         secondary: colors.base.onSurface,
                         tintedPrimary: colors.base.surface,
                         tintedSecondary: colors.base.onSurface)
        case .neutral:
            return .init(primary: colors.feedback.neutral,
                         secondary: colors.feedback.onNeutral,
                         tintedPrimary: colors.feedback.neutralContainer,
                         tintedSecondary: colors.feedback.onNeutralContainer)
        case .info:
            return .init(primary: colors.feedback.info,
                         secondary: colors.feedback.onInfo,
                         tintedPrimary: colors.feedback.infoContainer,
                         tintedSecondary: colors.feedback.onInfoContainer)
        case .success:
            return .init(primary: colors.feedback.success,
                         secondary: colors.feedback.onSuccess,
                         tintedPrimary: colors.feedback.successContainer,
                         tintedSecondary: colors.feedback.onSuccessContainer)
        case .alert:
            return .init(primary: colors.feedback.alert,
                         secondary: colors.feedback.onAlert,
                         tintedPrimary: colors.feedback.alertContainer,
                         tintedSecondary: colors.feedback.onAlertContainer)
        case .danger:
            return .init(primary: colors.feedback.error,
                         secondary: colors.feedback.onError,
                         tintedPrimary: colors.feedback.errorContainer,
                         tintedSecondary: colors.feedback.onErrorContainer)
        }
    }
}
