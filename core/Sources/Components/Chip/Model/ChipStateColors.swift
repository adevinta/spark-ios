//
//  ChipStateColors.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

/// The colors definie a chip
struct ChipStateColors {
    let background: any ColorToken
    let border: any ColorToken
    let foreground: any ColorToken
}

extension ChipStateColors: Equatable {
    static func == (lhs: ChipStateColors, rhs: ChipStateColors) -> Bool {
        return lhs.background.hashValue == rhs.background.hashValue &&
        lhs.border.hashValue  == rhs.border.hashValue &&
        lhs.foreground.hashValue  == rhs.foreground.hashValue
    }
}
