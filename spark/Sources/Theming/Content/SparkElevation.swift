//
//  SparkElevation.swift
//  Spark
//
//  Created by louis.borlee on 30/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import SparkCore

struct SparkElevation: Elevation {
    let dropShadow: any ElevationDropShadows & ElevationShadow = SparkDropShadow()
}

struct SparkDropShadow: ElevationDropShadows & ElevationShadow {

    let small: any ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 1),
        blur: 2,
        colorToken: SparkColorTokenShadow(),
        opacity: 0.20)
    let medium: any ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 6),
        blur: 12,
        colorToken: SparkColorTokenShadow(),
        opacity: 0.20)
    let large: any ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 8),
        blur: 16,
        colorToken: SparkColorTokenShadow(),
        opacity: 0.20)
    let extraLarge: any ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 12),
        blur: 24,
        colorToken: SparkColorTokenShadow(),
        opacity: 0.20)

    let offset: CGPoint = .init(x: 0, y: 4)
    let blur: CGFloat = 8
    let colorToken: any ColorToken = SparkColorTokenShadow()
    let opacity: Float = 0.20
}

fileprivate struct SparkColorTokenShadow: ColorToken {
    var uiColor: UIColor { .black }
    var color: Color { .black }
}
