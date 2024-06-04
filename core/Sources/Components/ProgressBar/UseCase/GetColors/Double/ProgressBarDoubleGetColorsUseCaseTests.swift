//
//  ProgressBarDoubleGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 20/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class ProgressBarDoubleGetColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let colorsMock = ColorsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_intent_is_accent_case() throws {
        try self.testExecute(
            givenIntent: .accent,
            expectedIndicatorBackgroundColorToken: self.colorsMock.accent.accent
        )
    }

    func test_execute_when_intent_is_alert_case() throws {
        try self.testExecute(
            givenIntent: .alert,
            expectedIndicatorBackgroundColorToken: self.colorsMock.feedback.alert
        )
    }

    func test_execute_when_intent_is_basic_case() throws {
        try self.testExecute(
            givenIntent: .basic,
            expectedIndicatorBackgroundColorToken: self.colorsMock.basic.basic
        )
    }

    func test_execute_when_intent_is_danger_case() throws {
        try self.testExecute(
            givenIntent: .danger,
            expectedIndicatorBackgroundColorToken: self.colorsMock.feedback.error
        )
    }

    func test_execute_when_intent_is_main_case() throws {
        try self.testExecute(
            givenIntent: .main,
            expectedIndicatorBackgroundColorToken: self.colorsMock.main.main
        )
    }

    func test_execute_when_intent_is_success_case() throws {
        try self.testExecute(
            givenIntent: .success,
            expectedIndicatorBackgroundColorToken: self.colorsMock.feedback.success
        )
    }
}

// MARK: - Execute Testing

private extension ProgressBarDoubleGetColorsUseCaseTests {

    func testExecute(
        givenIntent: ProgressBarDoubleIntent,
        expectedIndicatorBackgroundColorToken: any ColorToken
    ) throws {
        // GIVEN
        let dimsMock = DimsGeneratedMock.mocked()

        let expectedTrackBackgroundColorToken = self.colorsMock.base.onBackground.opacity(dimsMock.dim4)
        let bottomIndicatorBackgroundColorToken = expectedIndicatorBackgroundColorToken.opacity(dimsMock.dim3)

        let useCase = ProgressBarDoubleGetColorsUseCase()

        // WHEN
        let colors = useCase.execute(
            intent: givenIntent,
            colors: self.colorsMock,
            dims: dimsMock
        )

        // THEN
        XCTAssertEqual(
            colors.trackBackgroundColorToken.hashValue,
            expectedTrackBackgroundColorToken.hashValue,
            "Wrong trackBackgroundColorToken for .\(givenIntent) case"
        )
        XCTAssertIdentical(
            colors.indicatorBackgroundColorToken as? ColorTokenGeneratedMock,
            expectedIndicatorBackgroundColorToken as? ColorTokenGeneratedMock,
            "Wrong indicatorBackgroundColorToken for .\(givenIntent) case"
        )
        XCTAssertEqual(
            colors.bottomIndicatorBackgroundColorToken.hashValue,
            bottomIndicatorBackgroundColorToken.hashValue,
            "Wrong bottomIndicatorBackgroundColorToken for .\(givenIntent) case"
        )
    }
}
