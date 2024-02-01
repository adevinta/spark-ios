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
            switch variant {
            case .outlined: return self.getOutlinedColorsUseCase.execute(theme: theme, intent: intent, state: state)
            case .tinted: return self.getTintedColorsUseCase.execute(theme: theme, intent: intent, state: state)
            }
    }
}
