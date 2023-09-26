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
                border: theme.colors.feedback.error
            )
        case .alert:
            return .init(
                border: theme.colors.feedback.alert
            )
        case .neutral:
            return .init(
                border: theme.colors.feedback.neutral
            )
        case .success:
            return .init(
                border: theme.colors.feedback.success
            )
        }
    }
}
