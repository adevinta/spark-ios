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
    func execute(theme: Theme, state: RadioButtonGroupState, isSelected: Bool) -> RadioButtonColors
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
                 state: RadioButtonGroupState,
                 isSelected: Bool) -> RadioButtonColors {
        let buttonColor = theme.buttonColor(state: state, isSelected: isSelected)

        return RadioButtonColors(
            button: buttonColor,
            label: theme.colors.base.onSurface,
            halo: theme.haloColor(state: state),
            fill: isSelected ? buttonColor : ColorTokenDefault.clear
        )
    }
}

// MARK: - Private Extensions
private extension Theme {
    func buttonColor(state: RadioButtonGroupState,
                     isSelected: Bool) -> any ColorToken {
        switch state {
        case .warning: return self.colors.feedback.alert
        case .error: return self.colors.feedback.error
        case .success: return self.colors.feedback.success
        case .enabled, .disabled: return isSelected ? self.colors.main.main : self.colors.base.outline
        case .accent: return isSelected ? self.colors.accent.accent : self.colors.base.outline
        case .basic: return isSelected ? self.colors.basic.basic : self.colors.base.outline
        }
    }

    func haloColor(state: RadioButtonGroupState) -> any ColorToken {
        switch state {
        case .warning: return self.colors.feedback.alertContainer
        case .error: return self.colors.feedback.errorContainer
        case .success: return self.colors.feedback.successContainer
        case .disabled: return self.colors.main.mainContainer
        case .enabled: return self.colors.main.mainContainer
        case .accent: return self.colors.accent.accentContainer
        case .basic: return self.colors.basic.basicContainer
        }
    }
}
