//
//  TagColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagColorables {
    var backgroundColor: ColorToken { get }
    var borderColor: ColorToken { get }
    var foregroundColor: ColorToken { get }
}

struct TagColors: TagColorables {

    // MARK: - Properties

    let backgroundColor: ColorToken
    let borderColor: ColorToken
    let foregroundColor: ColorToken
}
