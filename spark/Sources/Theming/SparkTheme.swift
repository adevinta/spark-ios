//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore
import Foundation

public struct SparkTheme: Theme {

    // MARK: - Properties

    public static var shared = Self()

    public init() {}

    public let border: Border = SparkBorder()
    public var colors: Colors = SparkColors()
    public let elevation: Elevation = SparkElevation()
    public let layout: Layout = SparkLayout()
    public let typography: Typography = SparkTypography()
    public let dims: Dims = DimsDefault(dim1: 0.72,
                                        dim2: 0.56,
                                        dim3: 0.40,
                                        dim4: 0.16,
                                        dim5: 0.08)
}

public class SparkThemePublisher: ObservableObject {
    public static let shared = SparkThemePublisher()

    private init() {}

    @Published public var theme: Theme = SparkTheme()
}
