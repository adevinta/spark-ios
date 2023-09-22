//
//  TextFieldGetColorsUseCase.swift
//  SparkCore
//
//  Created by Quentin.richard on 21/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol TextFieldGetColorsUseCaseInterface {
    func execute(theme: Theme,
                 intent: TextFieldIntent) -> TextFieldColors
}

struct TextFieldGetColorsUseCase: TextFieldGetColorsUseCaseInterface {
    func execute(theme: Theme,
                 intent: TextFieldIntent) -> TextFieldColors {

        switch intent {
        case .error:
            return .init(
                labelColor: theme.colors.feedback.error,
                borderColor: theme.colors.feedback.error,
                helperColor: theme.colors.feedback.error,
                iconColor: theme.colors.feedback.error
            )
        case .alert:
            return .init(
                labelColor: theme.colors.feedback.alert,
                borderColor: theme.colors.feedback.alert,
                helperColor: theme.colors.feedback.alert,
                iconColor: theme.colors.feedback.alert
            )
        case .neutral:
            return .init(
                labelColor: theme.colors.feedback.neutral,
                borderColor: theme.colors.feedback.neutral,
                helperColor: theme.colors.feedback.neutral,
                iconColor: theme.colors.feedback.neutral
            )
        case .success:
            return .init(
                labelColor: theme.colors.feedback.success,
                borderColor: theme.colors.feedback.success,
                helperColor: theme.colors.feedback.success,
                iconColor: theme.colors.feedback.success
            )
        }
    }
}
