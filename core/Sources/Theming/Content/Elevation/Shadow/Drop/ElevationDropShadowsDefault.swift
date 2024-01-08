//
//  ElevationDropShadowsDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ElevationDropShadowsDefault: ElevationDropShadows {

    // MARK: - Properties
    
    public let small: any ElevationShadow
    public let medium: any ElevationShadow
    public let large: any ElevationShadow
    public let extraLarge: any ElevationShadow

    // MARK: - Init

    public init(small: some ElevationShadow,
                medium: some ElevationShadow,
                large: some ElevationShadow,
                extraLarge: some ElevationShadow) {
        self.small = small
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
    }
}
