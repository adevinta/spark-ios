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
    func execute(from colors: Colors, intent: FormFieldIntent) -> FormFieldColors
}

struct FormFieldColorsUseCase: FormFieldColorsUseCaseable {

    func execute(from colors: Colors, intent: FormFieldIntent) -> FormFieldColors {
        switch intent {
        case .error:
            return FormFieldColors(
                titleColor: colors.base.onSurface,
                descriptionColor: colors.feedback.error
            )
        case .success:
            return FormFieldColors(
                titleColor: colors.base.onSurface,
                descriptionColor: colors.feedback.success
            )
        case .alert:
            return FormFieldColors(
                titleColor: colors.base.onSurface,
                descriptionColor: colors.feedback.alert
            )
        case .support:
            return FormFieldColors(
                titleColor: colors.base.onSurface,
                descriptionColor: colors.support.support
            )
        case .base:
            return FormFieldColors(
                titleColor: colors.base.onSurface,
                descriptionColor: colors.base.onSurface
            )
        }
    }
}
