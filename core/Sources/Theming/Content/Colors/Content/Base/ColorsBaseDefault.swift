//
//  ColorsBaseDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsBaseDefault: ColorsBase {

    // MARK: - Properties

    public let background: any ColorToken
    public let onBackground: any ColorToken
    public let backgroundVariant: any ColorToken
    public let onBackgroundVariant: any ColorToken
    public let surface: any ColorToken
    public let onSurface: any ColorToken
    public let surfaceInverse: any ColorToken
    public let onSurfaceInverse: any ColorToken
    public let outline: any ColorToken
    public let outlineHigh: any ColorToken
    public let overlay: any ColorToken
    public let onOverlay: any ColorToken

    // MARK: - Init

    public init(background: any ColorToken,
                onBackground: any ColorToken,
                backgroundVariant: any ColorToken,
                onBackgroundVariant: any ColorToken,
                surface: any ColorToken,
                onSurface: any ColorToken,
                surfaceInverse: any ColorToken,
                onSurfaceInverse: any ColorToken,
                outline: any ColorToken,
                outlineHigh: any ColorToken,
                overlay: any ColorToken,
                onOverlay: any ColorToken) {
        self.background = background
        self.onBackground = onBackground
        self.backgroundVariant = backgroundVariant
        self.onBackgroundVariant = onBackgroundVariant
        self.surface = surface
        self.onSurface = onSurface
        self.surfaceInverse = surfaceInverse
        self.onSurfaceInverse = onSurfaceInverse
        self.outline = outline
        self.outlineHigh = outlineHigh
        self.overlay = overlay
        self.onOverlay = onOverlay
    }
}
