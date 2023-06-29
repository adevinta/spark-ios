//
//  ElevationShadowDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct ElevationShadowDefault: ElevationShadow {

    // MARK: - Properties

    public let offset: CGPoint
    public let blur: CGFloat
    public let colorToken: any ColorToken
    public let opacity: Float

    // MARK: - Init

    public init(offset: CGPoint,
                blur: CGFloat,
                colorToken: any ColorToken,
                opacity: Float) {
        self.offset = offset
        self.blur = blur
        self.colorToken = colorToken
        self.opacity = opacity
    }
}


