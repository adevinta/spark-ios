//
//  GetRadioButtonGroupColorUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 28.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol GetRadioButtonGroupColorUseCaseable {
    func execute(colors: Colors, state: RadioButtonGroupState) -> any ColorToken
}

/// GetRadioButtonGroupColorUseCase
/// Returns the color of the state of the radio button group
/// Functions:
/// - execute: takes a colors and states and returns a ``ColorToken`` defining the state.
struct GetRadioButtonGroupColorUseCase: GetRadioButtonGroupColorUseCaseable {
    // MARK: - Functions

    /// Return the color token corresponding to the state
    func execute(colors: Colors, state: RadioButtonGroupState) -> any ColorToken {
        switch state {
        case .warning: return colors.feedback.onAlertContainer
        case .error: return colors.feedback.error
        case .success: return colors.feedback.success
        case .enabled: return colors.main.mainContainer
        case .disabled: return colors.main.mainContainer
        case .accent: return colors.accent.accent
        case .basic: return colors.basic.basic
        }
    }
}
