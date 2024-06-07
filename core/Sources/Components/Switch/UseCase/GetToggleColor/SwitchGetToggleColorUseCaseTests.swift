//
//  SwitchGetToggleColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 23/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class SwitchGetToggleColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private var statusAndStateColorMock = SwitchStatusColors.mocked()

    // MARK: - Tests

    func test_execute_when_isOn_is_true() throws {
        try self.testExecute(
            givenIsOn: true,
            expectedColorToken: self.statusAndStateColorMock.onColorToken
        )
    }

    func test_execute_when_isOn_is_false() throws {
        try self.testExecute(
            givenIsOn: false,
            expectedColorToken: self.statusAndStateColorMock.offColorToken
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetToggleColorUseCaseTests {

    func testExecute(
        givenIsOn: Bool,
        expectedColorToken: any ColorToken
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for \(givenIsOn) isOn"

        let useCase = SwitchGetToggleColorUseCase()

        // WHEN
        let colorToken = useCase.execute(
            isOn: givenIsOn,
            statusAndStateColor: statusAndStateColorMock
        )

        // THEN
        XCTAssertEqual(colorToken as? ColorTokenGeneratedMock,
                       expectedColorToken as? ColorTokenGeneratedMock,
                       "Wrong interactionEnabled" + errorPrefixMessage)
    }
}
