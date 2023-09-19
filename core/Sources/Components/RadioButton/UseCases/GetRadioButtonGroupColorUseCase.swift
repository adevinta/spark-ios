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
    func execute(colors: Colors, intent: RadioButtonIntent) -> any ColorToken
}

/// GetRadioButtonGroupColorUseCase
/// Returns the color of the state of the radio button group
/// Functions:
/// - execute: takes a colors and states and returns a ``ColorToken`` defining the state.
struct GetRadioButtonGroupColorUseCase: GetRadioButtonGroupColorUseCaseable {
    // MARK: - Functions

    /// Return the color token corresponding to the state
    func execute(colors: Colors, intent: RadioButtonIntent) -> any ColorToken {
        switch intent {
        case .basic: return colors.basic.basic
        }
    }
}
