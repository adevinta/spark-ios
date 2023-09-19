//
//  RadioButtonGetAttributesUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 18.09.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

protocol RadioButtonGetAttributesUseCaseable {
    func execute(theme: Theme,
                 intent: RadioButtonIntent,
                 state: RadioButtonStateAttribute,
                 labelPosition: RadioButtonLabelPosition
    ) -> RadioButtonAttributes
}

struct RadioButtonGetAttributesUseCase: RadioButtonGetAttributesUseCaseable {
    let colorsUseCase: GetRadioButtonColorsUseCaseable

    init(colorsUseCase: GetRadioButtonColorsUseCaseable = GetRadioButtonColorsUseCase()) {
        self.colorsUseCase = colorsUseCase
    }
    func execute(theme: Theme,
                 intent: RadioButtonIntent,
                 state: RadioButtonStateAttribute,
                 labelPosition: RadioButtonLabelPosition
    ) -> RadioButtonAttributes {
        return RadioButtonAttributes(
            colors: self.colorsUseCase.execute(
                theme: theme,
                intent: intent,
                state: state),
            opacity: theme.opacity(state: state),
            spacing: theme.spacing(for: labelPosition),
            font: theme.typography.body1)
    }
}

// MARK: - Private Helpers
private extension Theme {
    func opacity(state: RadioButtonStateAttribute) -> CGFloat {
        return !state.isEnabled ? self.dims.dim3 : 1
    }

    func spacing(for labelPosition: RadioButtonLabelPosition) -> CGFloat {
        return labelPosition == .right ? self.layout.spacing.medium : self.layout.spacing.xxxLarge
    }
}
