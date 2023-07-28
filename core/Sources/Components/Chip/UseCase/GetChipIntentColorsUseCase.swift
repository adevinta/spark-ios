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
    func execute(colors: Colors, intentColor: ChipIntent) -> ChipIntentColors
}

/// GetChipIntentColorsUseCase: A use case to calculate the colors that are needed by a chip
struct GetChipIntentColorsUseCase: GetChipIntentColorsUseCasable {

    /// Function `execute` calculates the intent colors used by a chip
    ///
    /// Parameters:
    /// - colors: The available color palette
    /// - intent: The intent of the chip
    ///
    /// Returns: ChipIntentColors
    func execute(colors: Colors, intentColor: ChipIntent) -> ChipIntentColors {
        switch intentColor {
        case .main:
            return .init(principal: colors.main.main,
                         subordinate: colors.main.onMain,
                         tintedPrincipal: colors.main.mainContainer,
                         tintedSubordinate: colors.main.onMainContainer)
        case .support:
            return .init(principal: colors.support.support,
                         subordinate: colors.support.onSupport,
                         tintedPrincipal: colors.support.supportContainer,
                         tintedSubordinate: colors.support.onSupportContainer)
        case .surface:
            return .init(principal: colors.base.surface,
                         subordinate: colors.base.onSurface,
                         tintedPrincipal: colors.base.surface,
                         tintedSubordinate: colors.base.onSurface)
        case .neutral:
            return .init(principal: colors.feedback.neutral,
                         subordinate: colors.feedback.onNeutral,
                         tintedPrincipal: colors.feedback.neutralContainer,
                         tintedSubordinate: colors.feedback.onNeutralContainer)
        case .info:
            return .init(principal: colors.feedback.info,
                         subordinate: colors.feedback.onInfo,
                         tintedPrincipal: colors.feedback.infoContainer,
                         tintedSubordinate: colors.feedback.onInfoContainer)
        case .success:
            return .init(principal: colors.feedback.success,
                         subordinate: colors.feedback.onSuccess,
                         tintedPrincipal: colors.feedback.successContainer,
                         tintedSubordinate: colors.feedback.onSuccessContainer)
        case .alert:
            return .init(principal: colors.feedback.alert,
                         subordinate: colors.feedback.onAlert,
                         tintedPrincipal: colors.feedback.alertContainer,
                         tintedSubordinate: colors.feedback.onAlertContainer)
        case .danger:
            return .init(principal: colors.feedback.error,
                         subordinate: colors.feedback.onError,
                         tintedPrincipal: colors.feedback.errorContainer,
                         tintedSubordinate: colors.feedback.onErrorContainer)
        }
    }
}
