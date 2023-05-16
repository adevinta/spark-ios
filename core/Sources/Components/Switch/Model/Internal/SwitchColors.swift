//
//  SwitchColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol SwitchColorables {
    var backgroundColors: SwitchStatusAndStateColorables { get }

    var statusBackgroundColor: ColorToken { get }
    var statusForegroundColors: SwitchStatusAndStateColorables { get }

    var textForegroundColor: ColorToken { get }
}

struct SwitchColors: SwitchColorables {

    // MARK: - Properties

    let backgroundColors: SwitchStatusAndStateColorables

    let statusBackgroundColor: ColorToken
    let statusForegroundColors: SwitchStatusAndStateColorables

    let textForegroundColor: ColorToken
}

// MARK: - SwitchStatusAndStateColors

// sourcery: AutoMockable
protocol SwitchStatusAndStateColorables {
    var onAndSelectedColor: ColorToken { get }
    var onAndUnselectedColor: ColorToken { get }
    var offAndSelectedColor: ColorToken { get }
    var offAndUnselectedColor: ColorToken { get }
}

struct SwitchStatusAndStateColors: SwitchStatusAndStateColorables {

    // MARK: - Properties

    let onAndSelectedColor: ColorToken
    let onAndUnselectedColor: ColorToken
    let offAndSelectedColor: ColorToken
    let offAndUnselectedColor: ColorToken
}

