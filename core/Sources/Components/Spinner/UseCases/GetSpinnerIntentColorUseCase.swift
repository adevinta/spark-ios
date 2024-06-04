//
//  GetSpinnerIntentColorUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkTheming

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
    /// - Returns: ``ColorToken`` of the spinner.
    func execute(colors: any Colors, intent: SpinnerIntent) -> any ColorToken {
        switch intent {
        case .main: return colors.main.main
        case .support: return colors.support.support
        case .alert: return colors.feedback.alert
        case .error: return colors.feedback.error
        case .info: return colors.feedback.info
        case .neutral: return colors.feedback.neutral
        case .success: return colors.feedback.success
        case .accent: return colors.accent.accent
        case .basic: return colors.basic.basic
        }
    }
}
