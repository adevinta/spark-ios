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
                titleColor: theme.colors.base.onSurface,
                descriptionColor: theme.colors.base.onSurface.opacity(theme.dims.dim1), 
                asteriskColor: theme.colors.base.onSurface.opacity(theme.dims.dim3)
            )
        case .error:
            return FormFieldColors(
                titleColor: theme.colors.base.onSurface,
                descriptionColor: theme.colors.feedback.error, 
                asteriskColor: theme.colors.base.onSurface.opacity(theme.dims.dim3)
            )
        }
    }
}
