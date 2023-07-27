//
//  IconGetColorUseCase.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol IconGetColorUseCaseable {
    func execute(for intent: IconIntent, colors: Colors) -> any ColorToken
}

struct IconGetColorUseCase: IconGetColorUseCaseable {

    // MARK: - Methods

    func execute(for intent: IconIntent, colors: Colors) -> any ColorToken {
        switch intent {
        case .alert :
            return colors.feedback.alert
        case .error:
            return colors.feedback.error
        case .neutral:
            return colors.feedback.neutral
        case .primary:
            return colors.main.main
        case .secondary:
            return colors.support.support
        case .success:
            return colors.feedback.success
        }
    }
}
