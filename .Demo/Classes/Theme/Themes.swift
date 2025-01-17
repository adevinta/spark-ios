//
//  Themes.swift
//  SparkDemo
//
//  Created by robin.lemaire on 17/01/2025.
//  Copyright © 2025 Adevinta. All rights reserved.
//

import SparkTheming

enum Themes: String, CaseIterable {
    case spark
    case sky

    // MARK: - Properties

    var value: Theme {
        switch self {
        case .spark:
            SparkTheme.shared
        case .sky:
            SkyTheme.shared
        }
    }
}
