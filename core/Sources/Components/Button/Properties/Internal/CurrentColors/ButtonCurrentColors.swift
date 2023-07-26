//
//  ButtonCurrentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// Current Button Colors properties from a button colors and state
struct ButtonCurrentColors {

    // MARK: - Properties

    let iconTintColor: any ColorToken
    let textColor: (any ColorToken)?
    let backgroundColor: any ColorToken
    let borderColor: any ColorToken
}

// MARK: Hashable & Equatable

extension ButtonCurrentColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.iconTintColor)
        if let textColor = self.textColor {
            hasher.combine(textColor)
        }
        hasher.combine(self.backgroundColor)
        hasher.combine(self.borderColor)
    }

    static func == (lhs: ButtonCurrentColors, rhs: ButtonCurrentColors) -> Bool {
        return lhs.iconTintColor.equals(rhs.iconTintColor) &&
        lhs.textColor.equals(rhs.textColor) == true &&
        lhs.backgroundColor.equals(rhs.backgroundColor) &&
        lhs.borderColor.equals(rhs.borderColor)
    }
}
