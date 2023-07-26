//
//  SwitchGetColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let colorsMock = ColorsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_intent_is_alert_case() throws {
        try self.testExecute(
            givenIntent: .alert,
            expectedColorToken: self.colorsMock.feedback.alert
        )
    }

    func test_execute_when_intent_is_error_case() throws {
        try self.testExecute(
            givenIntent: .error,
            expectedColorToken: self.colorsMock.feedback.error
        )
    }

    func test_execute_when_intent_is_info_case() throws {
        try self.testExecute(
            givenIntent: .info,
            expectedColorToken: self.colorsMock.feedback.info
        )
    }

    func test_execute_when_intent_is_neutral_case() throws {
        try self.testExecute(
            givenIntent: .neutral,
            expectedColorToken: self.colorsMock.feedback.neutral
        )
    }

    func test_execute_when_intent_is_primary_case() throws {
        try self.testExecute(
            givenIntent: .primary,
            expectedColorToken: self.colorsMock.main.main
        )
    }

    func test_execute_when_intent_is_secondary_case() throws {
        try self.testExecute(
            givenIntent: .secondary,
            expectedColorToken: self.colorsMock.support.support
        )
    }

    func test_execute_when_intent_is_success_case() throws {
        try self.testExecute(
            givenIntent: .success,
            expectedColorToken: self.colorsMock.feedback.success
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetColorUseCaseTests {

    func testExecute(
        givenIntent: SwitchIntent,
        expectedColorToken: any ColorToken
    ) throws {
        // GIVEN
        let useCase = SwitchGetColorUseCase()
        
        // WHEN
        let colorToken = useCase.execute(
            intent: givenIntent,
            colors: self.colorsMock
        )
        
        // THEN
        XCTAssertIdentical(colorToken as? ColorTokenGeneratedMock,
                           expectedColorToken as? ColorTokenGeneratedMock,
                           "Wrong color for .\(givenIntent) case")
    }
}
