//
//  Elevation.swift
//  SparkCore
//
//  Created by louis.borlee on 27/03/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

public protocol Elevation {
    var dropShadow: any ElevationShadow & ElevationDropShadows { get }
}
