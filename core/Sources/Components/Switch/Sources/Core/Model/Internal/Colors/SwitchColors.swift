//
//  SwitchStatusColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

struct SwitchColors {

    // MARK: - Properties

    let toggleBackgroundColors: SwitchStatusColors
    let toggleDotForegroundColors: SwitchStatusColors
    let toggleDotBackgroundColor: any ColorToken
    let textForegroundColor: any ColorToken
}

// MARK: Hashable & Equatable

extension SwitchColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.toggleBackgroundColors)
        hasher.combine(self.toggleDotForegroundColors)
        hasher.combine(self.toggleDotBackgroundColor)
        hasher.combine(self.textForegroundColor)
    }

    static func == (lhs: SwitchColors, rhs: SwitchColors) -> Bool {
        return lhs.toggleBackgroundColors == rhs.toggleBackgroundColors &&
        lhs.toggleDotForegroundColors == rhs.toggleDotForegroundColors &&
        lhs.toggleDotBackgroundColor.equals(rhs.toggleDotBackgroundColor) &&
        lhs.textForegroundColor.equals(rhs.textForegroundColor)
    }
}
