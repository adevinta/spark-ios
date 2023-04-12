//
//  ElevationDropShadows.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public protocol ElevationDropShadows {
    var small: ElevationShadow { get }
    var medium: ElevationShadow { get }
    var large: ElevationShadow { get }
    var extraLarge: ElevationShadow { get }
    var none: ElevationShadow { get }
}

public extension ElevationDropShadows {
    var none: ElevationShadow {
        ElevationShadowDefault(offset: .zero,
                               blur: 0,
                               colorToken: ColorTokenDefault.clear,
                               opacity: 0)
    }
}
