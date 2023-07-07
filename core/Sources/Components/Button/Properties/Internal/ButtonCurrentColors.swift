//
//  ButtonCurrentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonCurrentColors {
    var foregroundColor: any ColorToken { get }
    var backgroundColor: any ColorToken { get }
    var borderColor: any ColorToken { get }
}

/// Current Button Colors properties from a button colors and state
struct ButtonCurrentColorsDefault: ButtonCurrentColors {

    // MARK: - Properties

    let foregroundColor: any ColorToken
    let backgroundColor: any ColorToken
    let borderColor: any ColorToken
}
