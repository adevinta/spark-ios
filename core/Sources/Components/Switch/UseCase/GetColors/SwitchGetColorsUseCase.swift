//
//  SwitchGetColorUseCase.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol SwitchGetColorsUseCaseable {
    func execute(forIntentColor intentColor: SwitchIntentColor,
                 colors: Colors,
                 dims: Dims) -> SwitchColors
}

struct SwitchGetColorsUseCase: SwitchGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorUseCase: any SwitchGetIntentColorUseCaseable

    // MARK: - Initialization

    init(getIntentColorUseCase: any SwitchGetIntentColorUseCaseable = SwitchGetIntentColorUseCase()) {
        self.getIntentColorUseCase = getIntentColorUseCase
    }

    // MARK: - Methods

    func execute(forIntentColor intentColor: SwitchIntentColor,
                 colors: Colors,
                 dims: Dims) -> SwitchColors {

        // Get intent color from use case
        let intentColor = self.getIntentColorUseCase.execute(
            forIntentColor: intentColor,
            colors: colors
        )

        let statusAndStateColors = SwitchStatusColorsDefault(
            onColorToken: intentColor,
            offColorToken: colors.base.onSurface.opacity(dims.dim4)
        )

        return SwitchColorsDefault(
            toggleBackgroundColors: statusAndStateColors,
            toggleDotForegroundColors: statusAndStateColors,
            toggleDotBackgroundColor: colors.base.surface,
            textForegroundColor: colors.base.onSurface
        )
    }
}
