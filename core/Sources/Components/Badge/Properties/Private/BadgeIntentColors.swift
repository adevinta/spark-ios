//
//  BadgeIntentColors.swift
//  Spark
//
//  Created by alex.vecherov on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol BadgeIntentColorables {
    var color: ColorToken { get }
    var onColor: ColorToken { get }
    var surface: ColorToken { get }
}

struct BadgeIntentColors: BadgeIntentColorables {

    // MARK: - Properties

    let color: ColorToken
    let onColor: ColorToken
    let surface: ColorToken
}
