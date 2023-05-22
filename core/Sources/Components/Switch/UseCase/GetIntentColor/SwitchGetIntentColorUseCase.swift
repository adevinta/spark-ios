//
//  SwitchGetIntentColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchGetIntentColorUseCaseable {
    func execute(for intentColor: SwitchIntentColor,
                 on colors: Colors) -> ColorToken
}

struct SwitchGetIntentColorUseCase: SwitchGetIntentColorUseCaseable {

    // MARK: - Methods

    func execute(for intentColor: SwitchIntentColor,
                 on colors: Colors) -> ColorToken {
        switch intentColor {
        case .alert:
            return colors.feedback.alert

        case .error:
            return colors.feedback.error

        case .info:
            return colors.feedback.info

        case .neutral:
            return colors.feedback.neutral

        case .primary:
            return colors.primary.primary

        case .secondary:
            return colors.secondary.secondary

        case .success:
            return colors.feedback.success
        }
    }
}
