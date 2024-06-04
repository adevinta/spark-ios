//
//  PurpleTheme.swift
//  Spark
//
//  Created by alex.vecherov on 01.06.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import Spark

public struct PurpleTheme: Theme {

    // MARK: - Properties

    public init() {}

    public static let shared = Self()

    public let border: Border = PurpleBorder()
    public let colors: Colors = PurpleColors()
    public let elevation: Elevation = SparkElevation()
    public let layout: Layout = PurpleLayout()
    public let typography: Typography = SparkTypography()
    public let dims: Dims = DimsDefault(dim1: 0.72,
                                        dim2: 0.56,
                                        dim3: 0.40,
                                        dim4: 0.16,
                                        dim5: 0.08)
}
