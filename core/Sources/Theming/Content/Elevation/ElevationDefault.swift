//
//  ElevationDefault.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public struct ElevationDefault: Elevation {

    // MARK: - Properties

    public let dropShadow: ElevationDropShadows & ElevationShadow

    // MARK: - Init

    public init(dropShadow: ElevationDropShadows & ElevationShadow) {
        self.dropShadow = dropShadow
    }
}
