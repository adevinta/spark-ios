//
//  ButtonCurrentColors.swift
//  SparkCore
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
protocol ButtonCurrentColors {
    var foregroundColor: ColorToken { get }
    var backgroundColor: ColorToken { get }
    var borderColor: ColorToken { get }
}

/// Current Button Colors properties from a button colors and state
struct ButtonCurrentColorsDefault: ButtonCurrentColors {

    // MARK: - Properties

    let foregroundColor: ColorToken
    let backgroundColor: ColorToken
    let borderColor: ColorToken
}
