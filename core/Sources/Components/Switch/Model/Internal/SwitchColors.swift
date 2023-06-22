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
    var toggleDotBackgroundColor: ColorToken { get }
    var toggleDotForegroundColors: SwitchStatusColorables { get }

    var textForegroundColor: ColorToken { get }
}

struct SwitchColors: SwitchColorables {

    // MARK: - Properties

    let toggleBackgroundColors: SwitchStatusColorables
    let toggleDotBackgroundColor: ColorToken
    let toggleDotForegroundColors: SwitchStatusColorables

    let textForegroundColor: ColorToken
}

// MARK: - SwitchStatusColors

// sourcery: AutoMockable
protocol SwitchStatusColorables {
    var onFullColorToken: FullColorToken { get }
    var offFullColorToken: FullColorToken { get }
}

struct SwitchStatusColors: SwitchStatusColorables {

    // MARK: - Properties

    let onFullColorToken: FullColorToken
    let offFullColorToken: FullColorToken
}
