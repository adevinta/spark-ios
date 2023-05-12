//
//  BadgeColors.swift
//  Spark
//
//  Created by alex.vecherov on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
protocol BadgeColorables {
    var backgroundColor: ColorToken { get }
    var borderColor: ColorToken { get }
    var foregroundColor: ColorToken { get }
}

struct BadgeColors: BadgeColorables {

    // MARK: - Properties

    let backgroundColor: ColorToken
    let borderColor: ColorToken
    let foregroundColor: ColorToken
}

