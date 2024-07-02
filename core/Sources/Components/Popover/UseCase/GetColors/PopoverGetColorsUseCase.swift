//
//  PopoverGetColorsUseCase.swift
//  Spark
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol PopoverGetColorsUseCasable {
    func execute(colors: Colors, intent: PopoverIntent) -> PopoverColors
}

final class PopoverGetColorsUseCase: PopoverGetColorsUseCasable {
    func execute(colors: Colors, intent: PopoverIntent) -> PopoverColors {
        switch intent {
        case .surface:
            return .init(
                background: colors.base.surface,
                foreground: colors.base.onSurface
            )
        case .main:
            return .init(
                background: colors.main.mainContainer,
                foreground: colors.main.onMainContainer
            )
        case .support:
            return .init(
                background: colors.support.supportContainer,
                foreground: colors.support.onSupportContainer
            )
        case .accent:
            return .init(
                background: colors.accent.accentContainer,
                foreground: colors.accent.onAccentContainer
            )
        case .basic:
            return .init(
                background: colors.basic.basicContainer,
                foreground: colors.basic.onBasicContainer
            )
        case .success:
            return .init(
                background: colors.feedback.successContainer,
                foreground: colors.feedback.onSuccessContainer
            )
        case .alert:
            return .init(
                background: colors.feedback.alertContainer,
                foreground: colors.feedback.onAlertContainer
            )
        case .error:
            return .init(
                background: colors.feedback.errorContainer,
                foreground: colors.feedback.onErrorContainer
            )
        case .info:
            return .init(
                background: colors.feedback.infoContainer,
                foreground: colors.feedback.onInfoContainer
            )
        case .neutral:
            return .init(
                background: colors.feedback.neutralContainer,
                foreground: colors.feedback.onNeutralContainer
            )
        }
    }
}
