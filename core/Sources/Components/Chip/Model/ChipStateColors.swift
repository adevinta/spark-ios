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
        return lhs.background.equals(rhs.background) &&
        lhs.border.equals(rhs.border) &&
        lhs.foreground.equals(rhs.foreground)
    }
}
