//
//  SkyTheme.swift
//  Spark
//
//  Created by alex.vecherov on 01.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

public struct SkyTheme: Theme {

    // MARK: - Properties

    public init() {}

    public static let shared = Self()

    public let border: Border = SkyBorder()
    public let colors: Colors = SkyColors()
    public let elevation: Elevation = SkyElevation()
    public let layout: Layout = SkyLayout()
    public let typography: Typography = SparkTypography()
    public let dims: Dims = SkyDims()
}
