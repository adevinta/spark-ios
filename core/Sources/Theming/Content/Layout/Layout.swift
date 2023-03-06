//
//  Layout.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//

import Foundation

public protocol Layout {
    var spacing: LayoutSpacing { get }
}

// MARK: - Spacing

public struct LayoutSpacing {

    // MARK: - Properties

    public let none: CGFloat = 0
    public let small: CGFloat
    public let medium: CGFloat
    public let large: CGFloat
    public let xLarge: CGFloat
    public let xxLarge: CGFloat
    public let xxxLarge: CGFloat

    // MARK: - Initialization

    public init(small: CGFloat,
                medium: CGFloat,
                large: CGFloat,
                xLarge: CGFloat,
                xxLarge: CGFloat,
                xxxLarge: CGFloat) {
        self.small = small
        self.medium = medium
        self.large = large
        self.xLarge = xLarge
        self.xxLarge = xxLarge
        self.xxxLarge = xxxLarge
    }
}
