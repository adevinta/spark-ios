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

final class SwitchGetToggleColorUseCaseTests: XCTestCase {

    // MARK: - Properties

    private var statusAndStateColorMock: SwitchStatusColorablesGeneratedMock = {
        let mock = SwitchStatusColorablesGeneratedMock()
        mock.underlyingOnFullColorToken = FullColorTokenGeneratedMock()
        mock.underlyingOffFullColorToken = FullColorTokenGeneratedMock()
        return mock
    }()

    // MARK: - Tests

    func test_execute_when_isOn_is_true() throws {
        try self.testExecute(
            givenIsOn: true,
            expectedColorToken: self.statusAndStateColorMock.onFullColorToken
        )
    }

    func test_execute_when_isOn_is_false() throws {
        try self.testExecute(
            givenIsOn: false,
            expectedColorToken: self.statusAndStateColorMock.offFullColorToken
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetToggleColorUseCaseTests {

    func testExecute(
        givenIsOn: Bool,
        expectedColorToken: FullColorToken
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for \(givenIsOn) isOn"

        let useCase = SwitchGetToggleColorUseCase()

        // WHEN
        let colorToken = useCase.execute(
            forIsOn: givenIsOn,
            statusAndStateColor: statusAndStateColorMock
        )

        // THEN
        XCTAssertIdentical(colorToken as? ColorTokenGeneratedMock,
                           expectedColorToken as? ColorTokenGeneratedMock,
                           "Wrong interactionEnabled" + errorPrefixMessage)
    }
}
