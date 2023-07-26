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

    func test_execute_when_icon_is_primary_case() {
        testExecute(givenIntent: .primary, expectedColorToken: self.colorsMock.primary.primary)
    }

    func test_execute_when_icon_is_secondary_case() {
        testExecute(givenIntent: .secondary, expectedColorToken: self.colorsMock.secondary.secondary)
    }

    func test_execute_when_icon_is_success_case() {
        testExecute(givenIntent: .success, expectedColorToken: self.colorsMock.feedback.success)
    }
}

// MARK: - Extension

private extension IconGetColorUseCaseTests {
    func testExecute(
        givenIntent: IconIntent,
        expectedColorToken: any ColorToken
    ) {
        // GIVEN
        let useCase = IconGetColorUseCaseableGeneratedMock()
        useCase.executeWithIntentAndColorsReturnValue = expectedColorToken

        // WHEN
        let colorToken = useCase.execute(
            for: givenIntent,
            colors: colorsMock
        )

        // THEN
        XCTAssertEqual(
            useCase.executeWithIntentAndColorsCallsCount,
            1,
            "Call to execute exceeds 1"
        )

        XCTAssertIdentical(
            colorToken as? ColorTokenGeneratedMock,
            expectedColorToken as? ColorTokenGeneratedMock,
            "Wrong color for .\(givenIntent) case"
        )
    }
}
