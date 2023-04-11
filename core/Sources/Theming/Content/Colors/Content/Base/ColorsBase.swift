//
//  ColorsBase.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ColorsBase {

    // MARK: - Background

    var background: ColorToken { get }
    var onBackground: ColorToken { get }
    var backgroundVariant: ColorToken { get }
    var onBackgroundVariant: ColorToken { get }

    // MARK: - Surface

    var surface: ColorToken { get }
    var onSurface: ColorToken { get }
    var surfaceInverse: ColorToken { get }
    var onSurfaceInverse: ColorToken { get }

    // MARK: - Outline

    var outline: ColorToken { get }
    var outlineHigh: ColorToken { get }

    // MARK: - Overlay

    var overlay: ColorToken { get }
    var onOverlay: ColorToken { get }
}
