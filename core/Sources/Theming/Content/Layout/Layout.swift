//
//  Layout.swift
//  SparkCore
//
//  Created by louis.borlee on 23/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public protocol Layout {
    var spacing: LayoutSpacing { get }
}

// MARK: - Spacing

public protocol LayoutSpacing {
    var none: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var xLarge: CGFloat { get }
    var xxLarge: CGFloat { get }
    var xxxLarge: CGFloat { get }
}

public extension LayoutSpacing {
    var none: CGFloat { 0 }
}
