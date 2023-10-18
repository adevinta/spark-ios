//
//  TextFieldGetColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Jacklyn Situmorang on 17.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class TextFieldGetColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_for_alert_case() {
        self.testExecute(
            givenIntent: .alert,
            expectedTextFieldColors: .init(border: self.themeMock.colors.feedback.alert)
        )
    }

    func test_execute_for_error_case() {
        self.testExecute(
            givenIntent: .error,
            expectedTextFieldColors: .init(border: self.themeMock.colors.feedback.error)
        )
    }

    func test_execute_for_neutral_case() {
        self.testExecute(
            givenIntent: .neutral,
            expectedTextFieldColors: .init(border: self.themeMock.colors.base.outline)
        )
    }

    func test_execute_for_success_case() {
        self.testExecute(
            givenIntent: .success,
            expectedTextFieldColors: .init(border: self.themeMock.colors.feedback.success)
        )
    }

}

private extension TextFieldGetColorsUseCaseTests {
    func testExecute(
        givenIntent: TextFieldIntent,
        expectedTextFieldColors: TextFieldColors
    ) {
        // GIVEN
        let useCase = TextFieldGetColorsUseCase()

        // WHEN
        let textFieldColors = useCase.execute(
            theme: self.themeMock,
            intent: givenIntent
        )

        // THEN
        XCTAssertIdentical(
            textFieldColors.border as? ColorTokenGeneratedMock,
            expectedTextFieldColors.border as? ColorTokenGeneratedMock,
            "Wrong color for .\(givenIntent) case"
        )
    }
}
