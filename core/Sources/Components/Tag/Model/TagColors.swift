//
//  TagColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol TagColorables {
    var backgroundColor: any ColorToken { get }
    var borderColor: any ColorToken { get }
    var foregroundColor: any ColorToken { get }
}

struct TagColors: TagColorables {

    // MARK: - Properties

    let backgroundColor: any ColorToken
    let borderColor: any ColorToken
    let foregroundColor: any ColorToken
}
