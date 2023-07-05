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
    func execute(colors: Colors, state: RadioButtonGroupState) -> ColorToken
}

struct GetRadioButtonGroupColorUseCase: GetRadioButtonGroupColorUseCaseable {
    func execute(colors: Colors, state: RadioButtonGroupState) -> ColorToken {
        switch state {
        case .warning: return colors.feedback.onAlertContainer
        case .error: return colors.feedback.error
        case .success: return colors.feedback.success
        case .enabled: return colors.primary.primaryContainer
        case .disabled: return colors.primary.primaryContainer
        }
    }
}
