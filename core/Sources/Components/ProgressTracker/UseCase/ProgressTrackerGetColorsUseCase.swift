//
//  ProgressTrackerGetColorsUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

protocol ProgressTrackerGetColorsUseCaseable {
    func execute(theme: Theme,
                 intent: ProgressTrackerIntent,
                 variant: ProgressTrackerVariant,
                 state: ProgressTrackerState) -> ProgressTrackerColors
}

struct ProgressTrackerGetColorsUseCase: ProgressTrackerGetColorsUseCaseable {
    let getTintedColorsUseCase: any ProgressTrackerGetVariantColorsUseCaseable
    let getOutlinedColorsUseCase: any ProgressTrackerGetVariantColorsUseCaseable

    init(
        getTintedColorsUseCase: some ProgressTrackerGetVariantColorsUseCaseable = ProgressTrackerGetTintedColorsUseCase(),
        getOutlinedColorsUseCase: some ProgressTrackerGetVariantColorsUseCaseable = ProgressTrackerGetOutlinedColorsUseCase()) {
        self.getTintedColorsUseCase = getTintedColorsUseCase
        self.getOutlinedColorsUseCase = getOutlinedColorsUseCase
    }

    func execute(theme: Theme, 
                 intent: ProgressTrackerIntent,
                 variant: ProgressTrackerVariant,
                 state: ProgressTrackerState) -> ProgressTrackerColors {
        let variantColors: ProgressTrackerColors = {
            switch variant {
            case .outlined: return self.getOutlinedColorsUseCase.execute(colors: theme.colors, intent: intent, state: state)
            case .tinted: return self.getTintedColorsUseCase.execute(colors: theme.colors, intent: intent, state: state)
            }
        }()

        if state.isDisabled {
            let disabledColors = variantColors.withOpacity(theme.dims.dim2)
            return ProgressTrackerColors(
                background: disabledColors.background,
                outline: disabledColors.outline,
                content: disabledColors.content,
                label: theme.colors.base.onSurface.opacity(theme.dims.dim1))
        } else {
            return variantColors
        }
    }
}
