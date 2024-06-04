//
//  RatingSizeAttributesUseCase.swift
//  SparkCore
//
//  Created by Michael Zimmermann on 20.11.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Foundation
import SparkTheming

// sourcery: AutoMockable
protocol RatingSizeAttributesUseCaseable {
    func execute(spacing: LayoutSpacing, size: RatingDisplaySize) -> RatingSizeAttributes
}

/// Calculates size attributes of the rating display according to the spacing and the size.
struct RatingSizeAttributesUseCase: RatingSizeAttributesUseCaseable {

    /// Returns: rating size attributes
    ///
    /// - Parameters:
    ///   - spacing: the spacing defined by the theme
    ///   - size: the size of the rating display
    func execute(spacing: LayoutSpacing, size: RatingDisplaySize) -> RatingSizeAttributes {
        switch size {
        case .small: return size.sizeAttributes(spacing: spacing.small)
        case .medium: return size.sizeAttributes(spacing: spacing.small)
        case .large: return size.sizeAttributes(spacing: spacing.small)
        case .input: return size.sizeAttributes(spacing: spacing.medium)
        }
    }
}

// MARK: - Private helpers
private extension RatingDisplaySize {
    func sizeAttributes(spacing: CGFloat) -> RatingSizeAttributes {
        switch self {
        case .small: return .init(borderWidth: 1.0, height: self.height, spacing: spacing)
        case .medium: return .init(borderWidth: 1.33, height: self.height, spacing: spacing)
        case .large: return .init(borderWidth: 2.0, height: self.height, spacing: spacing)
        case .input: return .init(borderWidth: 3.33, height: self.height, spacing: spacing)
        }
    }

    var height: CGFloat {
        return CGFloat(self.rawValue)
    }
}
