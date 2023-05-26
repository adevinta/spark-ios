//
//  TagIntentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagIntentColorables {
    var color: ColorToken { get }
    var onColor: ColorToken { get }
    var containerColor: ColorToken { get }
    var onContainerColor: ColorToken { get }
    var surfaceColor: ColorToken { get }
}

struct TagIntentColors: TagIntentColorables {

    // MARK: - Properties

    let color: ColorToken
    let onColor: ColorToken
    let containerColor: ColorToken
    let onContainerColor: ColorToken
    let surfaceColor: ColorToken
}
