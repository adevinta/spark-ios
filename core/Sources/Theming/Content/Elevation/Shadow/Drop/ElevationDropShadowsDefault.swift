//
//  ElevationDropShadowsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ElevationDropShadowsDefault: ElevationDropShadows {

    // MARK: - Properties

    public let small: ElevationShadow
    public let medium: ElevationShadow
    public let large: ElevationShadow
    public let extraLarge: ElevationShadow

    // MARK: - Init

    public init(small: ElevationShadow,
                medium: ElevationShadow,
                large: ElevationShadow,
                extraLarge: ElevationShadow) {
        self.small = small
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
    }
}
