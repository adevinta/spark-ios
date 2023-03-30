//
//  BorderDefault.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct BorderDefault: Border {

    // MARK: - Properties

    public let width: BorderWidth
    public let radius: BorderRadius

    // MARK: - Initialization

    public init(width: BorderWidth, radius: BorderRadius) {
        self.width = width
        self.radius = radius
    }
}

// MARK: - Width

public struct BorderWidthDefault: BorderWidth {

    // MARK: - Properties

    public let small: BorderWidthValue
    public let medium: BorderWidthValue

    // MARK: - Initialization

    public init(small: BorderWidthValue,
                medium: BorderWidthValue) {
        self.small = small
        self.medium = medium
    }
}

// MARK: - Radius

public struct BorderRadiusDefault: BorderRadius {

    // MARK: - Properties

    public let small: BorderRadiusValue
    public let medium: BorderRadiusValue
    public let large: BorderRadiusValue
    public let xLarge: BorderRadiusValue

    // MARK: - Initialization

    public init(small: BorderRadiusValue,
                medium: BorderRadiusValue,
                large: BorderRadiusValue,
                xLarge: BorderRadiusValue) {
        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
    }
}
