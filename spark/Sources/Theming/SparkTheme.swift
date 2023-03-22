//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Foundation

struct SparkTheme: Theme {

    // MARK: - Properties

    let border: Border = SparkBorder()
    let colors: Colors = SparkColors()
    let iconography: Iconography = SparkIconography()
    let layout: Layout = SparkLayout()
    let typography: Typography = SparkTypography()
    let dim: Dim = DimDefault(dim1: 0.72,
                              dim2: 0.56,
                              dim3: 0.40,
                              dim4: 0.16,
                              dim5: 0.08)
}
