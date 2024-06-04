//
//  IconGetColorUseCaseTests.swift
//  Spark
//
//  Created by Jacklyn Situmorang on 10.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkCore
import SparkThemingTesting

final class IconGetColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let colorsMock = ColorsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_icon_is_alert_case() {
        testExecute(givenIntent: .alert, expectedColorToken: self.colorsMock.feedback.alert)
    }

    func test_execute_when_icon_is_error_case() {
        testExecute(givenIntent: .error, expectedColorToken: self.colorsMock.feedback.error)
    }

    func test_execute_when_icon_is_neutral_case() {
        testExecute(givenIntent: .neutral, expectedColorToken: self.colorsMock.feedback.neutral)
    }

    func test_execute_when_icon_is_main_case() {
        testExecute(givenIntent: .main, expectedColorToken: self.colorsMock.main.main)
    }

    func test_execute_when_icon_is_support_case() {
        testExecute(givenIntent: .support, expectedColorToken: self.colorsMock.support.support)
    }

    func test_execute_when_icon_is_success_case() {
        testExecute(givenIntent: .success, expectedColorToken: self.colorsMock.feedback.success)
    }

    func test_execute_when_icon_is_accent_case() {
        testExecute(givenIntent: .accent, expectedColorToken: self.colorsMock.accent.accent)
    }

    func test_execute_when_icon_is_basic_case() {
        testExecute(givenIntent: .basic, expectedColorToken: self.colorsMock.basic.basic)
    }
}

// MARK: - Extension

private extension IconGetColorUseCaseTests {
    func testExecute(
        givenIntent: IconIntent,
        expectedColorToken: any ColorToken
    ) {
        // GIVEN
        let useCase = IconGetColorUseCase()

        // WHEN
        let colorToken = useCase.execute(
            for: givenIntent,
            colors: colorsMock
        )

        // THEN
        XCTAssertIdentical(
            colorToken as? ColorTokenGeneratedMock,
            expectedColorToken as? ColorTokenGeneratedMock,
            "Wrong color for .\(givenIntent) case"
        )
    }
}
