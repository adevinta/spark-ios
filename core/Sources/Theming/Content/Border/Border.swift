//
//  Border.swift
//  SparkCore
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public typealias BorderWidthValue = CGFloat
public typealias BorderRadiusValue = CGFloat

public protocol Border {
    var width: BorderWidth { get }
    var radius: BorderRadius { get }
}

// MARK: - Width

public protocol BorderWidth {
    var none: BorderWidthValue { get }
    var small: BorderWidthValue { get }
    var medium: BorderWidthValue { get }
}

public extension BorderWidth {
    var none: BorderWidthValue { 0 }
}

// MARK: - Radius

public protocol BorderRadius {
    var none: BorderRadiusValue { get }
    var small: BorderRadiusValue { get }
    var medium: BorderRadiusValue { get }
    var large: BorderRadiusValue { get }
    var xLarge: BorderRadiusValue { get }
    var full: BorderRadiusValue { get }
}

public extension BorderRadius {
    var none: BorderRadiusValue { 0 }
    var full: BorderRadiusValue { .infinity }
}
