//
//  SparkGetContentSizeCategoryUseCase.swift
//  Spark
//
//  Created by robin.lemaire on 07/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit
import SwiftUI

// sourcery: AutoMockable
protocol SparkGetContentSizeCategoryUseCaseable {
    func execute(from contentSizeCategory: ContentSizeCategory) -> SparkContentSizeCategory
    func execute(from uiContentSizeCategory: UIContentSizeCategory) -> SparkContentSizeCategory
}

struct SparkGetContentSizeCategoryUseCase: SparkGetContentSizeCategoryUseCaseable {
    
    // MARK: - Methods
    
    func execute(from contentSizeCategory: ContentSizeCategory) -> SparkContentSizeCategory {
        switch contentSizeCategory {
        case .extraSmall:
            return .xSmall
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        case .extraLarge:
            return .xLarge
        case .extraExtraLarge:
            return .xxLarge
        case .extraExtraExtraLarge:
            return .xxxLarge
        case .accessibilityMedium:
            return .accessibility1
        case .accessibilityLarge:
            return .accessibility2
        case .accessibilityExtraLarge:
            return .accessibility3
        case .accessibilityExtraExtraLarge:
            return .accessibility4
        case .accessibilityExtraExtraExtraLarge:
            return .accessibility5
        @unknown default:
            return .medium
        }
    }

    func execute(from uiContentSizeCategory: UIContentSizeCategory) -> SparkContentSizeCategory {
        switch uiContentSizeCategory {
        case .unspecified:
            return .medium
        case .extraSmall:
            return .xSmall
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        case .extraLarge:
            return .xLarge
        case .extraExtraLarge:
            return .xxLarge
        case .extraExtraExtraLarge:
            return .xxxLarge
        case .accessibilityMedium:
            return .accessibility1
        case .accessibilityLarge:
            return .accessibility2
        case .accessibilityExtraLarge:
            return .accessibility3
        case .accessibilityExtraExtraLarge:
            return .accessibility4
        case .accessibilityExtraExtraExtraLarge:
            return .accessibility5
        default:
            return .medium
        }
    }
}
