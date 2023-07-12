//
//  SwitchGetColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchGetColorUseCaseable {
    func execute(for intent: SwitchIntent,
                 colors: Colors) -> any ColorToken
}

struct SwitchGetColorUseCase: SwitchGetColorUseCaseable {

    // MARK: - Methods

    func execute(for intent: SwitchIntent,
                 colors: Colors) -> any ColorToken {
        switch intent {
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
