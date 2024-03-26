//
//  TextFieldGetColorsUseCase.swift
//  SparkCore
//
//  Created by Quentin.richard on 21/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TextFieldGetColorsUseCasable {
    func execute(theme: Theme,
                 intent: TextFieldIntent,
                 isFocused: Bool,
                 isEnabled: Bool,
                 isUserInteractionEnabled: Bool) -> TextFieldColors
}

struct TextFieldGetColorsUseCase: TextFieldGetColorsUseCasable {
    func execute(theme: Theme,
                 intent: TextFieldIntent,
                 isFocused: Bool,
                 isEnabled: Bool,
                 isUserInteractionEnabled: Bool) -> TextFieldColors {
        let text = theme.colors.base.onSurface
        let placeholder = theme.colors.base.onSurface.opacity(theme.dims.dim1)

        let border: any ColorToken
        let background: any ColorToken
        if isEnabled, isUserInteractionEnabled {
            switch intent {
            case .error:
                border = theme.colors.feedback.error
            case .alert:
                border = theme.colors.feedback.alert
            case .neutral:
                border = isFocused ? theme.colors.base.outlineHigh : theme.colors.base.outline
            case .success:
                border = theme.colors.feedback.success
            }
            background = theme.colors.base.surface
        } else {
            border = theme.colors.base.outline
            background = theme.colors.base.onSurface.opacity(theme.dims.dim5)
        }

        let statusIcon = theme.colors.feedback.neutral

        return .init(
            text: text,
            placeholder: placeholder,
            border: border,
            statusIcon: statusIcon,
            background: background
        )
    }
}
