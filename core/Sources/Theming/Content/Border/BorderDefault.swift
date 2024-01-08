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

    public let width: any BorderWidth
    public let radius: any BorderRadius

    // MARK: - Initialization

    public init(width: some BorderWidth, radius: some BorderRadius) {
        self.width = width
        self.radius = radius
    }
}

// MARK: - Width

public struct BorderWidthDefault: BorderWidth {

    // MARK: - Properties

    public let small: CGFloat
    public let medium: CGFloat

    // MARK: - Initialization

    public init(small: CGFloat,
                medium: CGFloat) {
        self.small = small
        self.medium = medium
    }
}

// MARK: - Radius

public struct BorderRadiusDefault: BorderRadius {

    // MARK: - Properties

    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat
    public let xLarge: CGFloat

    // MARK: - Initialization

    public init(small: CGFloat,
                medium: CGFloat,
                large: CGFloat,
                xLarge: CGFloat) {
        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
    }
}
