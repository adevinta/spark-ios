//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
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
}
