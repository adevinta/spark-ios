//
//  TagIntentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 29/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagIntentColorables {
    var color: any ColorToken { get }
    var onColor: any ColorToken { get }
    var containerColor: any ColorToken { get }
    var onContainerColor: any ColorToken { get }
    var surfaceColor: any ColorToken { get }
}

struct TagIntentColors: TagIntentColorables {

    // MARK: - Properties

    let color: any ColorToken
    let onColor: any ColorToken
    let containerColor: any ColorToken
    let onContainerColor: any ColorToken
    let surfaceColor: any ColorToken
}
