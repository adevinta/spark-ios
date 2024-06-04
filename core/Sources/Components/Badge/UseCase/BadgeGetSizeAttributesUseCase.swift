//
//  BadgeGetSizeUseCase.swift
//  SparkCore
//
//  Created by michael.zimmermann on 03.08.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SwiftUI
@_spi(SI_SPI) import SparkCommon
import SparkTheming

// sourcery: AutoMockable
protocol BadgeGetSizeAttributesUseCaseable {
    func execute(theme: Theme, size: BadgeSize) -> BadgeSizeDependentAttributes
}

/// A use case that returns size specific attributes according to the theme
struct BadgeGetSizeAttributesUseCase: BadgeGetSizeAttributesUseCaseable {

    // MARK: - Functions
    func execute(theme: Theme, size: BadgeSize) -> BadgeSizeDependentAttributes {
        return .init(offset: size.offset(spacing: theme.layout.spacing),
                     height: size.badgeHeight(),
                     font: size.font(typography: theme.typography))
    }
}

// MARK: - Private helper extension
private extension BadgeSize {
    func offset(spacing: LayoutSpacing) -> EdgeInsets {
        switch self {
        case .medium: return  .init(vertical: spacing.small,
                                    horizontal: spacing.medium)
        case .small: return .init(vertical: 0,
                                  horizontal: spacing.small)
        }
    }

    func badgeHeight() -> CGFloat {
        switch self {
        case .medium:
            return BadgeConstants.height.medium
        case .small:
            return BadgeConstants.height.small
        }
    }

    func font(typography: Typography) -> TypographyFontToken {
        switch self {
        case .medium:
            return typography.captionHighlight
        case .small:
            return typography.smallHighlight
        }
    }

}
