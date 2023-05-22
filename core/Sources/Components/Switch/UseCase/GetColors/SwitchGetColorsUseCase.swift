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
    func execute(for intentColor: SwitchIntentColor,
                 on colors: Colors) -> SwitchColorables
}

struct SwitchGetColorsUseCase: SwitchGetColorsUseCaseable {

    // MARK: - Properties

    private let getIntentColorUseCase: any SwitchGetIntentColorUseCaseable

    // MARK: - Initialization

    init(getIntentColorUseCase: any SwitchGetIntentColorUseCaseable = SwitchGetIntentColorUseCase()) {
        self.getIntentColorUseCase = getIntentColorUseCase
    }

    // MARK: - Methods

    func execute(for intentColor: SwitchIntentColor,
                 on colors: Colors) -> SwitchColorables {

        // Get intent color from use case
        let intentColor = self.getIntentColorUseCase.execute(
            for: intentColor,
            on: colors
        )

        let statusAndStateColors = SwitchStatusAndStateColors(
            onAndSelectedColor: intentColor,
            onAndUnselectedColor: colors.base.onSurface,
            offAndSelectedColor: intentColor,
            offAndUnselectedColor: colors.feedback.neutralContainer
        )

        return SwitchColors(
            backgroundColors: statusAndStateColors,
            statusBackgroundColor: colors.base.surface,
            statusForegroundColors: statusAndStateColors,
            textForegroundColor: colors.base.onSurface
        )
    }
}
