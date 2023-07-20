//
//  GetIconColorUseCase.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol GetIconColorUseCaseable {
    func execute(for intent: IconIntent, colors: Colors) -> IconColor
}

struct GetIconColorUseCase: GetIconColorUseCaseable {

    // MARK: - Methods

    func execute(for intent: IconIntent, colors: Colors) -> IconColor {
        var colorToken: any ColorToken

        switch intent {
        case .alert :
            colorToken = colors.feedback.alert
        case .error:
            colorToken = colors.feedback.error
        case .neutral:
            colorToken = colors.feedback.neutral
        case .primary:
            colorToken = colors.primary.primary
        case .secondary:
            colorToken = colors.secondary.secondary
        case .success:
            colorToken = colors.feedback.success
        }

        return .init(foreground: colorToken)
    }
}
