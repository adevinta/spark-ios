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
    func execute(colors: Colors,
                 intent: ProgressTrackerIntent,
                 variant: ProgressTrackerVariant,
                 state: ProgressTrackerState) -> ProgressTrackerColors
}

/// A use case that returns the color of the progress tracker indicator.
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
    /// Returns the colors of the progress tracker indicator
    func execute(
        colors: Colors,
        intent: ProgressTrackerIntent,
        variant: ProgressTrackerVariant,
        state: ProgressTrackerState) -> ProgressTrackerColors {
            switch variant {
            case .outlined: return self.getOutlinedColorsUseCase.execute(colors: colors, intent: intent, state: state)
            case .tinted: return self.getTintedColorsUseCase.execute(colors: colors, intent: intent, state: state)
            }
    }
}
