//
//  KleinanzeigenElevation.swift
//  Spark
//
//  Created by alex.vecherov on 05.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI
import SparkCore

struct KleinanzeigenElevation: Elevation {
    let dropShadow: ElevationDropShadows & ElevationShadow = KleinanzeigenDropShadow()
}

struct KleinanzeigenDropShadow: ElevationDropShadows & ElevationShadow {

    let small: ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 1),
        blur: 2,
        colorToken: KleinanzeigenColorTokenShadow(),
        opacity: 0.20)
    let medium: ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 6),
        blur: 12,
        colorToken: KleinanzeigenColorTokenShadow(),
        opacity: 0.20)
    let large: ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 8),
        blur: 16,
        colorToken: KleinanzeigenColorTokenShadow(),
        opacity: 0.20)
    let extraLarge: ElevationShadow = ElevationShadowDefault(
        offset: .init(x: 0, y: 12),
        blur: 24,
        colorToken: KleinanzeigenColorTokenShadow(),
        opacity: 0.20)

    let offset: CGPoint = .init(x: 0, y: 4)
    let blur: CGFloat = 8
    let colorToken: ColorToken = KleinanzeigenColorTokenShadow()
    let opacity: Float = 0.20
}

fileprivate struct KleinanzeigenColorTokenShadow: ColorToken {
    var uiColor: UIColor { .black }
    var color: Color { .black }
}
