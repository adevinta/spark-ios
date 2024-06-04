//
//  ChipGetIntentColorsUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

// sourcery: AutoMockable
protocol ChipGetIntentColorsUseCasable {
    func execute(theme: Theme, intent: ChipIntent) -> ChipIntentColors
}

/// ChipGetIntentColorsUseCase: A use case to calculate the colors that are needed by a chip
struct ChipGetOutlinedIntentColorsUseCase: ChipGetIntentColorsUseCasable {

    /// Function `execute` calculates the intent colors used by a chip
    ///
    /// Parameters:
    /// - theme: The availablethee
    /// - intent: The intent of the chip
    ///
    /// Returns: ChipIntentColors
    func execute(theme: Theme, intent: ChipIntent) -> ChipIntentColors {
        let colors = theme.colors
        let opacity = theme.dims.dim5

        switch intent {
        case .main: return .init(
            border: colors.main.main,
            text: colors.main.main,
            selectedText: colors.main.onMainContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.main.main.opacity(opacity),
            selectedBackground: colors.main.mainContainer
        )
            
        case .support: return .init(
            border: colors.support.support,
            text: colors.support.support,
            selectedText: colors.support.onSupportContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.support.support.opacity(opacity),
            selectedBackground: colors.support.supportContainer
        )
            
        case .surface: return .init(
            border: colors.base.surface,
            text: colors.base.surface,
            selectedText: colors.base.onSurface,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.base.surface.opacity(opacity),
            selectedBackground: colors.base.surface
        )
            
        case .neutral: return .init(
            border: colors.feedback.neutral,
            text: colors.feedback.neutral,
            selectedText: colors.feedback.onNeutralContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.feedback.neutral.opacity(opacity),
            selectedBackground: colors.feedback.neutralContainer
        )
            
        case .info: return .init(
            border: colors.feedback.info,
            text: colors.feedback.info,
            selectedText: colors.feedback.onInfoContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.feedback.info.opacity(opacity),
            selectedBackground: colors.feedback.infoContainer
        )
            
        case .success: return .init(
            border: colors.feedback.success,
            text: colors.feedback.success,
            selectedText: colors.feedback.onSuccessContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.feedback.success.opacity(opacity),
            selectedBackground: colors.feedback.successContainer
        )
            
        case .alert: return .init(
            border: colors.feedback.alert,
            text: colors.feedback.onAlertContainer,
            selectedText: colors.feedback.onAlertContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.feedback.alert.opacity(opacity),
            selectedBackground: colors.feedback.alertContainer
        )
            
        case .danger: return .init(
            border: colors.feedback.error,
            text: colors.feedback.error,
            selectedText: colors.feedback.onErrorContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.feedback.error.opacity(opacity),
            selectedBackground: colors.feedback.errorContainer
        )
            
        case .accent: return .init(
            border: colors.accent.accent,
            text: colors.accent.accent,
            selectedText: colors.accent.onAccentContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.accent.accent.opacity(opacity),
            selectedBackground: colors.accent.accentContainer
        )
            
        case .basic: return .init(
            border: colors.basic.basic,
            text: colors.basic.basic,
            selectedText: colors.basic.onBasicContainer,
            background: ColorTokenDefault.clear,
            pressedBackground: colors.basic.basic.opacity(opacity),
            selectedBackground: colors.basic.basicContainer
        )
        }
    }
}
