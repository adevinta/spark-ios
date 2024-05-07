//
//  FormFieldColorsUseCase.swift
//  SparkCore
//
//  Created by alican.aycil on 31.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol FormFieldColorsUseCaseable {
    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors
}

struct FormFieldColorsUseCase: FormFieldColorsUseCaseable {

    func execute(from theme: Theme, feedback state: FormFieldFeedbackState) -> FormFieldColors {
        switch state {
        case .default:
            return FormFieldColors(
                title: theme.colors.base.onSurface,
                description: theme.colors.base.onSurface.opacity(theme.dims.dim1),
                asterisk: theme.colors.base.onSurface.opacity(theme.dims.dim1)
            )
        case .error:
            return FormFieldColors(
                title: theme.colors.base.onSurface,
                description: theme.colors.feedback.error,
                asterisk: theme.colors.base.onSurface.opacity(theme.dims.dim1)
            )
        }
    }
}
