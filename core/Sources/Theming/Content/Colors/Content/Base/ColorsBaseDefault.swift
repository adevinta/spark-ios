//
//  ColorsBaseDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 23/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ColorsBaseDefault: ColorsBase {

    // MARK: - Properties

    public let background: ColorToken
    public let onBackground: ColorToken
    public let backgroundVariant: ColorToken
    public let onBackgroundVariant: ColorToken
    public let surface: ColorToken
    public let onSurface: ColorToken
    public let surfaceInverse: ColorToken
    public let onSurfaceInverse: ColorToken
    public let outline: ColorToken
    public let outlineHigh: ColorToken
    public let overlay: ColorToken
    public let onOverlay: ColorToken

    // MARK: - Init

    public init(background: ColorToken,
                onBackground: ColorToken,
                backgroundVariant: ColorToken,
                onBackgroundVariant: ColorToken,
                surface: ColorToken,
                onSurface: ColorToken,
                surfaceInverse: ColorToken,
                onSurfaceInverse: ColorToken,
                outline: ColorToken,
                outlineHigh: ColorToken,
                overlay: ColorToken,
                onOverlay: ColorToken) {
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
