//
//  BadgeGetIntentColorsUseCase.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol BadgeGetIntentColorsUseCaseable {
    func execute(intentType: BadgeIntentType,
                 on colors: Colors) -> BadgeColorables
}

class BadgeGetIntentColorsUseCase: BadgeGetIntentColorsUseCaseable {
    
    // MARK: - Methods

    func execute(intentType: BadgeIntentType,
                 on colors: Colors) -> BadgeColorables {
        let surfaceColor = colors.base.surface

        switch intentType {
        case .alert:
            return BadgeColors(
                backgroundColor: colors.feedback.alert,
                borderColor: surfaceColor,
                foregroundColor: colors.feedback.onAlert
            )
        case .danger:
            return BadgeColors(
                backgroundColor: colors.feedback.error,
                borderColor: surfaceColor,
                foregroundColor: colors.feedback.onError
            )
        case .info:
            return BadgeColors(
                backgroundColor: colors.feedback.info,
                borderColor: surfaceColor,
                foregroundColor: colors.feedback.onInfo
            )
        case .neutral:
            return BadgeColors(
                backgroundColor: colors.feedback.neutral,
                borderColor: surfaceColor,
                foregroundColor: colors.feedback.onNeutral
            )
        case .primary:
            return BadgeColors(
                backgroundColor: colors.primary.primary,
                borderColor: surfaceColor,
                foregroundColor: colors.primary.onPrimary
            )
        case .secondary:
            return BadgeColors(
                backgroundColor: colors.secondary.secondary,
                borderColor: surfaceColor,
                foregroundColor: colors.secondary.onSecondary
            )
        case .success:
            return BadgeColors(
                backgroundColor: colors.feedback.success,
                borderColor: surfaceColor,
                foregroundColor: colors.feedback.onSuccess
            )
        
        }
    }
}
