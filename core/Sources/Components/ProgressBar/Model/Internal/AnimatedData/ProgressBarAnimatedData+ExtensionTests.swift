//
//  ProgressBarAnimatedData+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 29/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import Foundation

extension ProgressBarAnimatedData {

    // MARK: - Properties

    static func mocked(
        leadingSpaceWidth: CGFloat = 1,
        indicatorWidth: CGFloat = 2
    ) -> Self {
        return .init(
            leadingSpaceWidth: leadingSpaceWidth,
            indicatorWidth: indicatorWidth
        )
    }
}
