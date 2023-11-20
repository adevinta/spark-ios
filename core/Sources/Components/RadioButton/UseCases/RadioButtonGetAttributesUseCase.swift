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
                 alignment: RadioButtonLabelAlignment
    ) -> RadioButtonAttributes
}

struct RadioButtonGetAttributesUseCase: RadioButtonGetAttributesUseCaseable {
    let colorsUseCase: RadioButtonGetColorsUseCaseable

    init(colorsUseCase: RadioButtonGetColorsUseCaseable = RadioButtonGetColorsUseCase()) {
        self.colorsUseCase = colorsUseCase
    }
    func execute(theme: Theme,
                 intent: RadioButtonIntent,
                 state: RadioButtonStateAttribute,
                 alignment: RadioButtonLabelAlignment
    ) -> RadioButtonAttributes {
        return RadioButtonAttributes(
            colors: self.colorsUseCase.execute(
                theme: theme,
                intent: intent,
                isSelected: state.isSelected),
            opacity: theme.opacity(isEnabled: state.isEnabled),
            spacing: theme.spacing(for: alignment),
            font: theme.typography.body1)
    }
}

// MARK: - Private Helpers
private extension Theme {
    func opacity(isEnabled: Bool) -> CGFloat {
        return !isEnabled ? self.dims.dim3 : 1
    }

    func spacing(for alignment: RadioButtonLabelAlignment) -> CGFloat {
        return alignment == .trailing ? self.layout.spacing.medium : self.layout.spacing.xxxLarge
    }
}
