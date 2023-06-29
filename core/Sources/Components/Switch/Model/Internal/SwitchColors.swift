//
//  SwitchColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchColorables {
    var toggleBackgroundColors: SwitchStatusColorables { get }
    var toggleDotBackgroundColor: any ColorToken { get }
    var toggleDotForegroundColors: SwitchStatusColorables { get }

    var textForegroundColor: any ColorToken { get }
}

struct SwitchColors: SwitchColorables {

    // MARK: - Properties

    let toggleBackgroundColors: SwitchStatusColorables
    let toggleDotBackgroundColor: any ColorToken
    let toggleDotForegroundColors: SwitchStatusColorables

    let textForegroundColor: any ColorToken
}

// MARK: - SwitchStatusColors

// sourcery: AutoMockable
protocol SwitchStatusColorables {
    var onColorToken: any ColorToken { get }
    var offColorToken: any ColorToken { get }
}

struct SwitchStatusColors: SwitchStatusColorables {

    // MARK: - Properties

    let onColorToken: any ColorToken
    let offColorToken: any ColorToken
}
