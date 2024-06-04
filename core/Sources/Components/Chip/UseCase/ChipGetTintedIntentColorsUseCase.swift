//
//  ChipGetTintedIntentColorsUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

struct ChipGetTintedIntentColorsUseCase: ChipGetIntentColorsUseCasable {

    /// Function `execute` calculates the intent colors used by a chip
    ///
    /// Parameters:
    /// - theme: The availablethee
    /// - intent: The intent of the chip
    ///
    /// Returns: ChipIntentColors
    func execute(theme: Theme, intent: ChipIntent) -> ChipIntentColors {
        let colors = theme.colors

        switch intent {
        case .main: return .init(
            border: colors.main.mainContainer,
            text: colors.main.onMainContainer,
            selectedText: colors.main.onMain,
            background: colors.main.mainContainer,
            pressedBackground: colors.states.mainContainerPressed,
            selectedBackground: colors.main.main
        )

        case .support: return .init(
            border: colors.support.supportContainer,
            text: colors.support.onSupportContainer,
            selectedText: colors.support.onSupport,
            background: colors.support.supportContainer,
            pressedBackground: colors.states.supportContainerPressed,
            selectedBackground: colors.support.support
        )

        case .surface: return .init(
            border: ColorTokenDefault.clear,
            text: colors.base.surfaceInverse,
            selectedText: colors.base.onSurface,
            background: colors.base.surface.opacity(theme.dims.dim1),
            pressedBackground: colors.states.surfacePressed,
            selectedBackground: colors.base.surface,
            disabledBackground: colors.base.surface
        )

        case .neutral: return .init(
            border: colors.feedback.neutralContainer,
            text: colors.feedback.onNeutralContainer,
            selectedText: colors.feedback.onNeutral,
            background: colors.feedback.neutralContainer,
            pressedBackground: colors.states.neutralContainerPressed,
            selectedBackground: colors.feedback.neutral
        )

        case .info: return .init(
            border: colors.feedback.infoContainer,
            text: colors.feedback.onInfoContainer,
            selectedText: colors.feedback.onInfo,
            background: colors.feedback.infoContainer,
            pressedBackground: colors.states.infoContainerPressed,
            selectedBackground: colors.feedback.info
        )

        case .success: return .init(
            border: colors.feedback.successContainer,
            text: colors.feedback.onSuccessContainer,
            selectedText: colors.feedback.onSuccess,
            background: colors.feedback.successContainer,
            pressedBackground: colors.states.successContainerPressed,
            selectedBackground: colors.feedback.success
        )

        case .alert: return .init(
            border: colors.feedback.alertContainer,
            text: colors.feedback.onAlertContainer,
            selectedText: colors.feedback.onAlert,
            background: colors.feedback.alertContainer,
            pressedBackground: colors.states.alertContainerPressed,
            selectedBackground: colors.feedback.alert
        )

        case .danger: return .init(
            border: colors.feedback.errorContainer,
            text: colors.feedback.onErrorContainer,
            selectedText: colors.feedback.onError,
            background: colors.feedback.errorContainer,
            pressedBackground: colors.states.errorContainerPressed,
            selectedBackground: colors.feedback.error
        )

        case .accent: return .init(
            border: colors.accent.accentContainer,
            text: colors.accent.onAccentContainer,
            selectedText: colors.accent.onAccent,
            background: colors.accent.accentContainer,
            pressedBackground: colors.states.accentContainerPressed,
            selectedBackground: colors.accent.accent
        )

        case .basic: return .init(
            border: colors.basic.basicContainer,
            text: colors.basic.onBasicContainer,
            selectedText: colors.basic.onBasic,
            background: colors.basic.basicContainer,
            pressedBackground: colors.states.basicContainerPressed,
            selectedBackground: colors.basic.basic
        )
        }
    }}
