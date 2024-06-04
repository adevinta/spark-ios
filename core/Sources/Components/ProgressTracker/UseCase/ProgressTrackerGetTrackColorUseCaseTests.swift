//
//  ProgressTrackerGetTrackColorUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 24.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkThemingTesting

final class ProgressTrackerGetTrackColorUseCaseTests: XCTestCase {

    // MARK: - Properties
    var sut: ProgressTrackerGetTrackColorUseCase!
    var colors: ColorsGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.colors = ColorsGeneratedMock.mocked()
        self.sut = ProgressTrackerGetTrackColorUseCase()
    }

    // MARK: - Tests
    func test_all_intents() {
        let expectedColors: [ProgressTrackerIntent: any ColorToken] =
        [
            .accent: self.colors.accent.accent,
            .alert: self.colors.feedback.alert,
            .basic: self.colors.basic.basic,
            .danger: self.colors.feedback.error,
            .info: self.colors.feedback.info,
            .main: self.colors.main.main,
            .neutral: self.colors.feedback.neutral,
            .success: self.colors.feedback.success,
            .support: self.colors.support.support
        ]

        for intent in ProgressTrackerIntent.allCases {
            let expectedColor = expectedColors[intent]
            let givenColor = self.sut.execute(colors: self.colors, intent: intent)
            XCTAssertTrue(expectedColor?.equals(givenColor) == true, "Enabled color for \(intent) is not as expected")
        }
    }
}
