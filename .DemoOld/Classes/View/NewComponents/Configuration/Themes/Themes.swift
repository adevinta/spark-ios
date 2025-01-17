//
//  Themes.swift
//  SparkDemo
//
//  Created by louis.borlee on 20/09/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Foundation

enum Themes: CaseIterable, Hashable {
    case spark
    case sky

    var current: any Theme {
        switch self {
        case .sky: return SkyTheme()
        case .spark: return SparkTheme.shared
        }
    }
}
