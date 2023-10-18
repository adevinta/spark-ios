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
            label: theme.colors.base.onBackground,
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
            return  state.isSelected ? self.selectedColor(intent: intent) : self.base.outline
    }

    private func selectedColor(intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic:
            return self.basic.basic
        case .support:
            return self.support.support
        case .alert:
            return self.feedback.alert
        case .danger:
            return self.feedback.error
        case .info:
            return self.feedback.info
        case .neutral:
            return self.feedback.neutral
        case .accent:
            return self.accent.accent
        case .main:
            return self.main.main
        case .success:
            return self.feedback.success
        }
    }

    func surfaceColor(intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic: 
            return self.base.onSurface
        case .support:
            return self.support.onSupport
        case .alert:
            return self.feedback.onAlert
        case .danger:
            return self.feedback.onError
        case .info:
            return self.feedback.onInfo
        case .neutral:
            return self.feedback.onNeutral
        case .accent:
            return self.accent.onAccent
        case .main:
            return self.main.onMain
        case .success:
            return self.feedback.success
        }
    }

    func haloColor(intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic:
            return self.basic.basicContainer
        case .accent:
            return self.accent.accentContainer
        case .alert:
            return self.feedback.alertContainer
        case .info:
            return self.feedback.infoContainer
        case .support:
            return self.support.supportContainer
        case .danger:
            return self.feedback.errorContainer
        case .neutral:
            return self.feedback.neutralContainer
        case .main:
            return self.main.mainContainer
        case .success:
            return self.feedback.success
        }
    }
}
