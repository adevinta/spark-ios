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

struct GetSpinnerIntentColorUseCase: GetSpinnerIntentColorUseCasable {
    func execute(colors: any Colors, intent: SpinnerIntent) -> any ColorToken {
        switch intent {
        case .primary: return colors.primary.primary
        case .secondary: return colors.secondary.secondary
        case .alert: return colors.feedback.alert
        case .error: return colors.feedback.error
        case .info: return colors.feedback.info
        case .neutral: return colors.feedback.neutral
        case .success: return colors.feedback.success
        }
    }
}
