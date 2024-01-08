//
//  ElevationDropShadows.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

// sourcery: AutoMockable
public protocol ElevationDropShadows {
    var small: any ElevationShadow { get }
    var medium: any ElevationShadow { get }
    var large: any ElevationShadow { get }
    var extraLarge: any ElevationShadow { get }
    var none: any ElevationShadow { get }
}

public extension ElevationDropShadows {
    var none: any ElevationShadow {
        ElevationShadowDefault(offset: .zero,
                               blur: 0,
                               colorToken: ColorTokenDefault.clear,
                               opacity: 0)
    }
}
