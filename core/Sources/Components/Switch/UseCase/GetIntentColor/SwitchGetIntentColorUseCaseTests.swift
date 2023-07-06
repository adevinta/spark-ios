//
//  SwitchGetIntentColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetIntentColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let colorsMock = ColorsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_switchIntentColor_is_alert_case() throws {
        try self.testExecute(
            givenIntentColor: .alert,
            expectedColorToken: self.colorsMock.feedback.alert
        )
    }

    func test_execute_when_switchIntentColor_is_error_case() throws {
        try self.testExecute(
            givenIntentColor: .error,
            expectedColorToken: self.colorsMock.feedback.error
        )
    }

    func test_execute_when_switchIntentColor_is_info_case() throws {
        try self.testExecute(
            givenIntentColor: .info,
            expectedColorToken: self.colorsMock.feedback.info
        )
    }

    func test_execute_when_switchIntentColor_is_neutral_case() throws {
        try self.testExecute(
            givenIntentColor: .neutral,
            expectedColorToken: self.colorsMock.feedback.neutral
        )
    }

    func test_execute_when_switchIntentColor_is_primary_case() throws {
        try self.testExecute(
            givenIntentColor: .primary,
            expectedColorToken: self.colorsMock.primary.primary
        )
    }

    func test_execute_when_switchIntentColor_is_secondary_case() throws {
        try self.testExecute(
            givenIntentColor: .secondary,
            expectedColorToken: self.colorsMock.secondary.secondary
        )
    }

    func test_execute_when_switchIntentColor_is_success_case() throws {
        try self.testExecute(
            givenIntentColor: .success,
            expectedColorToken: self.colorsMock.feedback.success
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetIntentColorUseCaseTests {

    func testExecute(
        givenIntentColor: SwitchIntentColor,
        expectedColorToken: any ColorToken
    ) throws {
        // GIVEN
        let useCase = SwitchGetIntentColorUseCase()
        
        // WHEN
        let colorToken = useCase.execute(
            forIntentColor: givenIntentColor,
            colors: self.colorsMock
        )
        
        // THEN
        XCTAssertIdentical(colorToken as? ColorTokenGeneratedMock,
                           expectedColorToken as? ColorTokenGeneratedMock,
                           "Wrong color for .\(givenIntentColor) case")
    }
}
