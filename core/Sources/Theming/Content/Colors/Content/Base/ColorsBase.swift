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

    var background: any ColorToken { get }
    var onBackground: any ColorToken { get }
    var backgroundVariant: any ColorToken { get }
    var onBackgroundVariant: any ColorToken { get }

    // MARK: - Surface

    var surface: any ColorToken { get }
    var onSurface: any ColorToken { get }
    var surfaceInverse: any ColorToken { get }
    var onSurfaceInverse: any ColorToken { get }

    // MARK: - Outline

    var outline: any ColorToken { get }
    var outlineHigh: any ColorToken { get }

    // MARK: - Overlay

    var overlay: any ColorToken { get }
    var onOverlay: any ColorToken { get }
}
