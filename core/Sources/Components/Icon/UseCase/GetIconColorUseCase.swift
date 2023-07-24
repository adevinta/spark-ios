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
    func execute(for intent: IconIntent, colors: Colors) -> any ColorToken
}

struct GetIconColorUseCase: GetIconColorUseCaseable {

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
            return colors.primary.primary
        case .secondary:
            return colors.secondary.secondary
        case .success:
            return colors.feedback.success
        }
    }
}
