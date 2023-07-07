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

    let foregroundColor: any ColorToken
    let backgroundColor: any ColorToken
    let borderColor: any ColorToken
}

// MARK: Hashable & Equatable

extension ButtonCurrentColors: Hashable, Equatable {

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.foregroundColor)
        hasher.combine(self.backgroundColor)
        hasher.combine(self.borderColor)
    }

    static func == (lhs: ButtonCurrentColors, rhs: ButtonCurrentColors) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

