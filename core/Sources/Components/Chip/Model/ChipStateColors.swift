//
//  ChipStateColors.swift
//  SparkCore
//
//  Created by michael.zimmermann on 08.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// The colors definie a chip
struct ChipStateColors {
    let background: any ColorToken
    let border: any ColorToken
    let foreground: any ColorToken
    var opacity: CGFloat

    init(background: any ColorToken, border: any ColorToken, foreground: any ColorToken, opacity: CGFloat = 1.0) {
        self.background = background
        self.border = border
        self.foreground = foreground
        self.opacity = opacity
    }
}

extension ChipStateColors: Equatable {
    static func == (lhs: ChipStateColors, rhs: ChipStateColors) -> Bool {
        return lhs.background.equals(rhs.background) &&
        lhs.border.equals(rhs.border) &&
        lhs.foreground.equals(rhs.foreground) && lhs.opacity == rhs.opacity
    }
}
