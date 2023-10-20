//
//  ComponentSnapshotTestConstants.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import UIKit

enum ComponentSnapshotTestConstants {
    static let record = false
    static let timeout: TimeInterval = 5

    static let imagePrecision: Float = 0.98
    static let imagePerceptualPrecision: Float = 0.98

    enum Modes {
        static let all: [ComponentSnapshotTestMode] = [.light, .dark]
        static let `default`: [ComponentSnapshotTestMode] = [.light]
    }

    enum Sizes {
        static let all: [UIContentSizeCategory] = [.extraSmall, .medium, .accessibilityExtraExtraExtraLarge]
        static let `default`: [UIContentSizeCategory] = [.medium]
    }
}
