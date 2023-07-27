//
//  GetSpinnerIntentColorUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol GetSpinnerIntentColorUseCasable {
    func execute(colors: any Colors, intent: SpinnerIntent) -> any ColorToken
}

/// GetSpinnerIntentColorUseCase
/// Use case to determin the colors of the Spinner by the intent
/// Functions:
/// - execute: returns a color token for given colors and an intent
struct GetSpinnerIntentColorUseCase: GetSpinnerIntentColorUseCasable {

    // MARK: - Functions
    ///
    /// Calculate the color of the spinner depending on the intent
    ///
    /// - Parameters:
    ///    - colors: Colors from the theme
    ///    - intent: `SpinnerIntent`.
    ///
    /// - Returns: ``RadioButtonColors`` which contains the various colors of the radio button.
    func execute(colors: any Colors, intent: SpinnerIntent) -> any ColorToken {
        switch intent {
        case .primary: return colors.main.main
        case .secondary: return colors.support.support
        case .alert: return colors.feedback.alert
        case .error: return colors.feedback.error
        case .info: return colors.feedback.info
        case .neutral: return colors.feedback.neutral
        case .success: return colors.feedback.success
        }
    }
}
