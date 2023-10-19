//
//  AddOnGetColorUseCase.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 28.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol AddOnGetColorUseCasable {
    func execute(
        theme: Theme,
        intent: TextFieldIntent
    ) -> any ColorToken
}

struct AddOnGetColorUseCase: AddOnGetColorUseCasable {
    func execute(
        theme: Theme,
        intent: TextFieldIntent
    ) -> any ColorToken {
        switch intent {
        case .error:
            return theme.colors.feedback.error
        case .alert:
            return theme.colors.feedback.alert
        case .neutral:
            return theme.colors.base.outline
        case .success:
            return theme.colors.feedback.success
        }
    }
}
