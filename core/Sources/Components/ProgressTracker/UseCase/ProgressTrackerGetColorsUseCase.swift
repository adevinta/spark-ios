//
//  ProgressTrackerGetColorsUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 11.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol ProgressTrackerGetColorsUseCaseable {
    func execute(theme: Theme,
                 intent: ProgressTrackerIntent,
                 variant: ProgressTrackerVariant,
                 state: ProgressTrackerState) -> ProgressTrackerColors
}

/// A use case that returns the color of the progress tracker.
struct ProgressTrackerGetColorsUseCase: ProgressTrackerGetColorsUseCaseable {

    // MARK: - Properties
    let getTintedColorsUseCase: any ProgressTrackerGetVariantColorsUseCaseable
    let getOutlinedColorsUseCase: any ProgressTrackerGetVariantColorsUseCaseable

    // MARK: - Initialization
    init(
        getTintedColorsUseCase: some ProgressTrackerGetVariantColorsUseCaseable = ProgressTrackerGetTintedColorsUseCase(),
        getOutlinedColorsUseCase: some ProgressTrackerGetVariantColorsUseCaseable = ProgressTrackerGetOutlinedColorsUseCase()) {
        self.getTintedColorsUseCase = getTintedColorsUseCase
        self.getOutlinedColorsUseCase = getOutlinedColorsUseCase
    }

    // MARK: Execute
    func execute(
        theme: Theme,
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
            let background = variantColors.background.equals(ColorTokenDefault.clear) ? variantColors.background : variantColors.background.opacity(theme.dims.dim2)
            return ProgressTrackerColors(
                background: background,
                outline: variantColors.outline.opacity(theme.dims.dim2),
                content: variantColors.content.opacity(theme.dims.dim2)
                )
        } else {
            return variantColors
        }
    }
}
