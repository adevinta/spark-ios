//
//  ProgressTrackerGetTrackColorUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ProgressTrackerGetTrackColorUseCaseTests: XCTestCase {

    // MARK: - Properties
    var sut: ProgressTrackerGetTrackColorUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.theme = ThemeGeneratedMock.mocked()
        self.sut = ProgressTrackerGetTrackColorUseCase()
    }

    // MARK: - Tests
    func test_all_intents() {
        let colors = self.theme.colors
        let expectedColors: [ProgressTrackerIntent: any ColorToken] =
        [
            .accent: colors.accent.accent,
            .alert: colors.feedback.alert,
            .basic: colors.basic.basic,
            .danger: colors.feedback.error,
            .info: colors.feedback.info,
            .main: colors.main.main,
            .neutral: colors.feedback.neutral,
            .success: colors.feedback.success,
            .support: colors.support.support
        ]

        for intent in ProgressTrackerIntent.allCases {
            let expectedColor = expectedColors[intent]
            let givenColor = self.sut.execute(theme: self.theme, intent: intent, isEnabled: true)
            XCTAssertTrue(expectedColor?.equals(givenColor) == true, "Enabled color for \(intent) is not as expected")
        }

        for intent in ProgressTrackerIntent.allCases {
            let expectedColor = expectedColors[intent]?.opacity(self.theme.dims.dim3)
            let givenColor = self.sut.execute(theme: self.theme, intent: intent, isEnabled: false)
            XCTAssertTrue(expectedColor?.equals(givenColor) == true, "Disabled color for \(intent) is not as expected")
        }

    }
}
