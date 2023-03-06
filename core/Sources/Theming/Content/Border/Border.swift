//
//  Border.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/02/2023.
//

import Foundation

public protocol Border {
    var width: BorderWidth { get }
    var radius: BorderRadius { get }
}

// MARK: - Width

public struct BorderWidth {

    // MARK: - Properties

    public let none: CGFloat = 0
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

public struct BorderRadius {

    // MARK: - Properties

    public let none: CGFloat = 0
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
