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
    func execute(theme: Theme, state: SparkSelectButtonState, isSelected: Bool) -> RadioButtonColorables
}

/// A use case to determine the colors of a radio button.
/// Properties:
/// - theming: Contains state and theme of the radio button ``RadioButtonTheming``
///
/// Functions:
/// - execute: takes a parameter if the radio button is selected or not, and returns a ``RadioButtonColorables`` defining the various colors of the radion button.
struct GetRadioButtonColorsUseCase: GetRadioButtonColorsUseCaseable {

    // MARK: - Functions
    ///
    /// Calculate the colors of the radio button depending on it's state and whether it is selected or not.
    ///
    /// - Parameters:
    ///    - isSelected = true, when the radion button is selected, false otherwise.
    ///
    /// - Returns: ``RadioButtonColorables`` which contains the various colors of the radio button.
    func execute(theme: Theme,
                 state: SparkSelectButtonState,
                 isSelected: Bool) -> RadioButtonColorables {
        let buttonColor = theme.buttonColor(state: state, isSelected: isSelected)

        return RadioButtonColors(
            button: buttonColor,
            label: theme.colors.base.onSurface,
            halo: theme.haloColor(state: state),
            fill: isSelected ? buttonColor : nil,
            subLabel: theme.supplementaryTextColor(state: state)
        )
    }
}

// MARK: - Private Extensions
private extension Theme {
    func buttonColor(state: SparkSelectButtonState,
                     isSelected: Bool) -> ColorToken {
        switch state {
        case .warning: return self.colors.feedback.alert
        case .error: return self.colors.feedback.error
        case .success: return self.colors.feedback.success
        case .enabled, .disabled: return isSelected ? self.colors.primary.primary : self.colors.base.outline
        }
    }

    func supplementaryTextColor(state: SparkSelectButtonState) -> ColorToken? {
        switch state {
        case .warning: return self.colors.feedback.onAlertContainer
        case .error: return self.colors.feedback.error
        case .success: return self.colors.feedback.success
        case .enabled: return nil
        case .disabled: return nil
        }
    }

    func haloColor(state: SparkSelectButtonState) -> ColorToken {
        switch state {
        case .warning: return self.colors.feedback.alertContainer
        case .error: return self.colors.feedback.errorContainer
        case .success: return self.colors.feedback.successContainer
        case .disabled: return self.colors.primary.primaryContainer
        case .enabled: return self.colors.primary.primaryContainer
        }
    }
}
