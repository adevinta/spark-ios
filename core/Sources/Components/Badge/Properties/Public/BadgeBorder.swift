//
//  BadgeBorder.swift
//  SparkDemo
//
//  Created by alex.vecherov on 17.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Structure that is used for configuring border of ``BadgeView``
///
/// List of properties:
/// - width
/// - radius
/// - color returned as ColorToken
public struct BadgeBorder {
    var width: CGFloat
    let radius: CGFloat
    var color: ColorToken

    mutating func setWidth(_ width: CGFloat) {
        self.width = width
    }

    mutating func setColor(_ color: ColorToken) {
        self.color = color
    }
}
