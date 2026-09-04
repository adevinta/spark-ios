//
//  XXXContentColors.swift
//  SparkComponentXXX
//
//  Created by robin.lemaire on 23/02/2026.
//  Copyright © 2026 Leboncoin. All rights reserved.
//

import Foundation
@_spi(SI_SPI) import SparkTheming

struct XXXContentColors: Equatable {

    // MARK: - Properties

    var tintColorToken: any ColorToken = ColorTokenClear()
    var backgroundColorToken: any ColorToken = ColorTokenClear()
}

// MARK: Hashable & Equatable

extension XXXContentColors {

    static func == (lhs: XXXContentColors, rhs: XXXContentColors) -> Bool {
        return lhs.tintColorToken.equals(rhs.tintColorToken) &&
        lhs.backgroundColorToken.equals(rhs.backgroundColorToken)
    }
}
