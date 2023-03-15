//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SparkCore

struct SparkBorder: Border {

    // MARK: - Properties

    let width: BorderWidth = BorderWidthDefault(small: 1,
                                                medium: 2)
    let radius: BorderRadius = BorderRadiusDefault(small: 4,
                                                   medium: 8,
                                                   large: 16,
                                                   xLarge: 24)
}
