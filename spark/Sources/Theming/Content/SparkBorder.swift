//
//  SparkTheme.swift
//  Spark
//
//  Created by robin.lemaire on 28/02/2023.
//

import SparkCore

struct SparkBorder: Border {

    // MARK: - Properties

    let width: BorderWidth = .init(small: 1,
                                   medium: 2)
    let radius: BorderRadius = .init(small: 4,
                                     medium: 8,
                                     large: 16,
                                     xLarge: 24)
}
