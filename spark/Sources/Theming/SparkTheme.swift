//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SparkCore
import Foundation

public struct SparkTheme: Theme {

    // MARK: - Properties

    public static var shared = Self()

    public init() {}

    public let border: any Border = SparkBorder()
    public var colors: any Colors = SparkColors()
    public let elevation: any Elevation = SparkElevation()
    public let layout: any Layout = SparkLayout()
    public let typography: any Typography = SparkTypography()
    public let dims: any Dims = DimsDefault(dim1: 0.72,
                                            dim2: 0.56,
                                            dim3: 0.40,
                                            dim4: 0.16,
                                            dim5: 0.08)
}
