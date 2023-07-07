//
//  SwitchColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchColors {
    var toggleBackgroundColors: SwitchStatusColors { get }
    var toggleDotForegroundColors: SwitchStatusColors { get }
    var toggleDotBackgroundColor: any ColorToken { get }

    var textForegroundColor: any ColorToken { get }
}

struct SwitchColorsDefault: SwitchColors {

    // MARK: - Properties

    let toggleBackgroundColors: SwitchStatusColors
    let toggleDotForegroundColors: SwitchStatusColors
    let toggleDotBackgroundColor: any ColorToken

    let textForegroundColor: any ColorToken
}

// MARK: - SwitchStatusColorsDefault

// sourcery: AutoMockable
protocol SwitchStatusColors {
    var onColorToken: any ColorToken { get }
    var offColorToken: any ColorToken { get }
}

struct SwitchStatusColorsDefault: SwitchStatusColors {

    // MARK: - Properties

    let onColorToken: any ColorToken
    let offColorToken: any ColorToken
}
