//
//  AddOnGetColorUseCaseTests.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 17.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class AddOnGetColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_for_alert_case() {
        self.testExecute(
            givenIntent: .alert,
            expectedColorToken: self.themeMock.colors.feedback.alert
        )
    }

    func test_execute_for_error_case() {
        self.testExecute(
            givenIntent: .error,
            expectedColorToken: self.themeMock.colors.feedback.error
        )
    }

    func test_execute_for_neutral_case() {
        self.testExecute(
            givenIntent: .neutral,
            expectedColorToken: self.themeMock.colors.base.outline
        )
    }

    func test_execute_for_success_case() {
        self.testExecute(
            givenIntent: .success,
            expectedColorToken: self.themeMock.colors.feedback.success
        )
    }
}

// MARK: - Extension

private extension AddOnGetColorUseCaseTests {
    func testExecute(
        givenIntent: TextFieldIntent,
        expectedColorToken: any ColorToken
    ) {
        // GIVEN
        let useCase = AddOnGetColorUseCase()

        // WHEN
        let colorToken = useCase.execute(
            theme: self.themeMock,
            intent: givenIntent
        )

        // THEN
        XCTAssertIdentical(
            colorToken as? ColorTokenGeneratedMock,
            expectedColorToken as? ColorTokenGeneratedMock,
            "Wrong color for .\(givenIntent) case"
        )
    }
}
