//
//  GetRadioButtonColorsUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 11.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol GetRadioButtonColorsUseCaseable {
    func execute(theme: Theme,
                 intent: RadioButtonIntent,
                 state: RadioButtonStateAttribute) -> RadioButtonColors
}

/// A use case to determine the colors of a radio button.
/// Properties:
/// - theming: Contains state and theme of the radio button ``RadioButtonTheming``
///
/// Functions:
/// - execute: takes a parameter if the radio button is selected or not, and returns a ``RadioButtonColors`` defining the various colors of the radion button.
struct GetRadioButtonColorsUseCase: GetRadioButtonColorsUseCaseable {

    // MARK: - Functions
    ///
    /// Calculate the colors of the radio button depending on it's state and whether it is selected or not.
    ///
    /// - Parameters:
    ///    - isSelected = true, when the radion button is selected, false otherwise.
    ///
    /// - Returns: ``RadioButtonColors`` which contains the various colors of the radio button.
    func execute(theme: Theme,
                 intent: RadioButtonIntent,
                 state: RadioButtonStateAttribute) -> RadioButtonColors {
        let buttonColor = theme.colors.buttonColor(
            intent: intent,
            state: state)

        return RadioButtonColors(
            button: buttonColor,
            label: theme.colors.base.onSurface,
            halo: theme.colors.haloColor(intent: intent),
            fill: state.isSelected ? buttonColor : ColorTokenDefault.clear,
            surface: theme.colors.surfaceColor(intent: intent)
        )
    }
}

// MARK: - Private Extensions
private extension SparkCore.Colors {
    func buttonColor(
        intent: RadioButtonIntent,
        state: RadioButtonStateAttribute) -> any ColorToken {

            switch intent {
            case .basic:
                return state.isSelected ? self.basic.basic : self.base.outline
            }
        //        switch state {
//        case .warning: return self.colors.feedback.alert
//        case .error: return self.colors.feedback.error
//        case .success: return self.colors.feedback.success
//        case .enabled, .disabled: return isSelected ? self.colors.main.main : self.colors.base.outline
//        case .accent: return isSelected ? self.colors.accent.accent : self.colors.base.outline
//        case .basic: return isSelected ? self.colors.basic.basic : self.colors.base.outline
//        }
    }

    func surfaceColor(intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic: return self.base.onSurface
        }
    }

    func haloColor(intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic:
            return self.basic.basicContainer
//        switch state {
//        case .warning: return self.colors.feedback.alertContainer
//        case .error: return self.colors.feedback.errorContainer
//        case .success: return self.colors.feedback.successContainer
//        case .disabled: return self.colors.main.mainContainer
//        case .enabled: return self.colors.main.mainContainer
//        case .accent: return self.colors.accent.accentContainer
//        case .basic: return self.colors.basic.basicContainer
        }
    }
}
