//
//  SwitchColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkThemingTesting

extension SwitchColors {

    // MARK: - Properties

    static func mocked(
        toggleBackgroundColors: SwitchStatusColors = .mocked(),
        toggleDotForegroundColors: SwitchStatusColors = .mocked(),
        toggleDotBackgroundColor: any ColorToken = ColorTokenGeneratedMock.random(),
        textForegroundColor: any ColorToken = ColorTokenGeneratedMock.random()
    ) -> Self {
        return .init(
            toggleBackgroundColors: toggleBackgroundColors,
            toggleDotForegroundColors: toggleDotForegroundColors,
            toggleDotBackgroundColor: toggleDotBackgroundColor,
            textForegroundColor: textForegroundColor
        )
    }
}
