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
                 on colors: Colors) -> BadgeColors
}

final class BadgeGetIntentColorsUseCase: BadgeGetIntentColorsUseCaseable {

    // MARK: - Methods

    func execute(intentType: BadgeIntentType,
                 on colors: Colors) -> BadgeColors {
        let surfaceColor = colors.base.surface

        switch intentType {
        case .accent:
            return BadgeColors(
                backgroundColor: colors.accent.accent,
                borderColor: surfaceColor,
                foregroundColor: colors.accent.onAccent
            )
        case .basic:
            return BadgeColors(
                backgroundColor: colors.basic.basic,
                borderColor: surfaceColor,
                foregroundColor: colors.basic.onBasic
            )
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
        case .main:
            return BadgeColors(
                backgroundColor: colors.main.main,
                borderColor: surfaceColor,
                foregroundColor: colors.main.onMain
            )
        case .support:
            return BadgeColors(
                backgroundColor: colors.support.support,
                borderColor: surfaceColor,
                foregroundColor: colors.support.onSupport
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
