//
//  ProgressBarColors+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SparkThemingTesting

extension ProgressBarColors {

    // MARK: - Properties

    static func mocked(
        trackBackgroundColorToken: any ColorToken = ColorTokenGeneratedMock.random(),
        indicatorBackgroundColorToken: any ColorToken = ColorTokenGeneratedMock.random()
    ) -> Self {
        return .init(
            trackBackgroundColorToken: trackBackgroundColorToken,
            indicatorBackgroundColorToken: indicatorBackgroundColorToken
        )
    }
}
