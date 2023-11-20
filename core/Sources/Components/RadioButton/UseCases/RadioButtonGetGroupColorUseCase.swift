//
//  RadioButtonGetGroupColorUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 28.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol RadioButtonGetGroupColorUseCaseable {
    func execute(colors: Colors, intent: RadioButtonIntent) -> any ColorToken
}

/// GetRadioButtonGroupColorUseCase
/// Returns the color of the state of the radio button group
/// Functions:
/// - execute: takes a colors and states and returns a ``ColorToken`` defining the state.
struct RadioButtonGetGroupColorUseCase: RadioButtonGetGroupColorUseCaseable {
    // MARK: - Functions

    /// Return the color token corresponding to the state
    func execute(colors: Colors, intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic: 
            return colors.basic.basic
        case .support:
            return colors.support.support
        case .alert:
            return colors.feedback.alert
        case .danger:
            return colors.feedback.error
        case .info:
            return colors.feedback.info
        case .neutral:
            return colors.feedback.neutral
        case .accent:
            return colors.accent.accent
        case .main:
            return colors.main.main
        case .success:
            return colors.feedback.success
        }
    }
}
