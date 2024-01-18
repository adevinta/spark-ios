//
//  ProgressTrackerGetOutlinedColorsUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

/// A use case to calculate the outlined colors of the progress tracker
struct ProgressTrackerGetOutlinedColorsUseCase: ProgressTrackerGetVariantColorsUseCaseable {

    func execute(colors: Colors,
                 intent: ProgressTrackerIntent,
                 state: ProgressTrackerState
    ) -> ProgressTrackerColors {
        let intentColors: ProgressTrackerOutlinedColors = {
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
            outline: intentColors.outline,
            content: intentColors.content,
            label: colors.base.onSurface)
    }

    private func pressedColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerOutlinedColors {
        switch intent {
        case .accent:
            return .init(
                background: colors.states.accentContainerPressed,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.states.alertContainerPressed,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.states.basicContainerPressed,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.states.errorContainerPressed,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.states.infoContainerPressed,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.states.mainContainerPressed,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.states.neutralContainerPressed,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.states.successContainerPressed,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.states.supportContainerPressed,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }

    private func selectedColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerOutlinedColors {

        switch intent {
        case .accent:
            return .init(
                background: colors.accent.accentContainer,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.feedback.alertContainer,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.basic.basicContainer,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.feedback.errorContainer,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.feedback.infoContainer,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.main.mainContainer,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.feedback.neutralContainer,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.feedback.successContainer,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.support.supportContainer,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }

    private func enabledColors(colors: Colors, intent: ProgressTrackerIntent) -> ProgressTrackerOutlinedColors {
        switch intent {
        case .accent:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }
}
