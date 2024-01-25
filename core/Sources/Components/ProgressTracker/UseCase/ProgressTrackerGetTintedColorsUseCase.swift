//
//  ProgressTrackerGetTintedColorsUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

/// A use case to calculate the tinted colors of the progress tracker
struct ProgressTrackerGetTintedColorsUseCase: ProgressTrackerGetVariantColorsUseCaseable {

    func execute(colors: Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors {
        let intentColors: ProgressTrackerTintedColors = {
            if state.isPressed {
                return self.pressedColors(colors: colors, intent: intent)
            } else if state.isSelected {
                return self.selectedColors(colors: colors, intent: intent)
            } else {
                return self.enabledColors(colors: colors, intent: intent)
            }
        }()

        return ProgressTrackerColors(
            background: intentColors.background,
            outline: intentColors.background,
            content: intentColors.content)
    }

    private func pressedColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {
        switch intent {
        case .accent:
            return .init(
                background: colors.states.accentContainerPressed,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.states.alertContainerPressed,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.states.basicContainerPressed,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.states.errorContainerPressed,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.states.infoContainerPressed,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.states.mainContainerPressed,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.states.neutralContainerPressed,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.states.successContainerPressed,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.states.supportContainerPressed,
                content: colors.support.onSupportContainer)
        }
    }

    private func selectedColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {

        switch intent {
        case .accent:
            return .init(
                background: colors.accent.accent,
                content: colors.accent.onAccent)
        case .alert:
            return .init(
                background: colors.feedback.alert,
                content: colors.feedback.onAlert)
        case .basic:
            return .init(
                background: colors.basic.basic,
                content: colors.basic.onBasic)
        case .danger:
            return .init(
                background: colors.feedback.error,
                content: colors.feedback.onError)
        case .info:
            return .init(
                background: colors.feedback.info,
                content: colors.feedback.onInfo)
        case .main:
            return .init(
                background: colors.main.main,
                content: colors.main.onMain)
        case .neutral:
            return .init(
                background: colors.feedback.neutral,
                content: colors.feedback.onNeutral)
        case .success:
            return .init(
                background: colors.feedback.success,
                content: colors.feedback.onSuccess)
        case .support:
            return .init(
                background: colors.support.support,
                content: colors.support.onSupport)
        }
    }

    private func enabledColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerTintedColors {
        switch intent {
        case .accent: 
            return .init(
                background: colors.accent.accentContainer,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.feedback.alertContainer,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.basic.basicContainer,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.feedback.errorContainer,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.feedback.infoContainer,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.main.mainContainer,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.feedback.neutralContainer,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.feedback.successContainer,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.support.supportContainer,
                content: colors.support.onSupportContainer)
        }
    }
}

