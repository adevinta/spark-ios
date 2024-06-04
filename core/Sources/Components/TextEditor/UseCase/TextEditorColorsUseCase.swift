//
//  TextEditorColorsUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 25.05.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol TextEditorColorsUseCasable {
    func execute(theme: Theme,
                 intent: TextEditorIntent,
                 isFocused: Bool,
                 isEnabled: Bool,
                 isReadonly: Bool) -> TextEditorColors
}

struct TextEditorColorsUseCase: TextEditorColorsUseCasable {

    func execute(theme: Theme,
                 intent: TextEditorIntent,
                 isFocused: Bool,
                 isEnabled: Bool,
                 isReadonly: Bool) -> TextEditorColors {

        var text = theme.colors.base.onSurface
        let placeholder = theme.colors.base.onSurface.opacity(theme.dims.dim1)
        let border: any ColorToken
        let background: any ColorToken

        if !isEnabled || isReadonly {
            let dim = isReadonly ? theme.dims.dim3 : theme.dims.none
            text = theme.colors.base.onSurface.opacity(dim)
            border = theme.colors.base.onSurface.opacity(theme.dims.dim3)
            background = theme.colors.base.onSurface.opacity(theme.dims.dim5)
        } else {
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
        }

        return .init(
            text: text,
            placeholder: placeholder,
            border: border,
            background: background
        )
    }
}
