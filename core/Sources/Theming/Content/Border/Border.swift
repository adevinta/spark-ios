//
//  Border.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
public protocol Border {
    var width: BorderWidth { get }
    var radius: BorderRadius { get }
}

// MARK: - Width

// sourcery: AutoMockable
public protocol BorderWidth {
    var none: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
}

public extension BorderWidth {
    var none: CGFloat { 0 }
}

// MARK: - Radius

// sourcery: AutoMockable
public protocol BorderRadius {
    var none: CGFloat { get }
    var small: CGFloat { get }
    var medium: CGFloat { get }
    var large: CGFloat { get }
    var xLarge: CGFloat { get }
    var full: CGFloat { get }
}

public extension BorderRadius {
    var none: CGFloat { 0 }
    var full: CGFloat { .infinity }
}
