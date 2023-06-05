//
//  BadgeSize.swift
//  SparkDemo
//
//  Created by alex.vecherov on 17.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation

/// Enum that sets ``BadgeView`` size
///
/// There are two possible sizes:
/// - normal
/// - small
public enum BadgeSize {
    case normal
    case small

    func fontSize(for theme: Theme) -> TypographyFontToken {
        switch self {
        case .normal:
            return theme.typography.captionHighlight
        case .small:
            return theme.typography.smallHighlight
        }
    }
}
