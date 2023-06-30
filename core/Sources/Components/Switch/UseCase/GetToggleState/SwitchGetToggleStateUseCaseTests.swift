//
//  SwitchGetToggleStateUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetToggleStateUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let dimsMock = DimsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_isEnabled_is_true() throws {
        try self.testExecute(
            givenIsEnabled: true,
            expectedInteractionState: .init(interactionEnabled: true, opacity: self.dimsMock.none)
        )
    }

    func test_execute_when_isEnabled_is_false() throws {
        try self.testExecute(
            givenIsEnabled: false,
            expectedInteractionState: .init(interactionEnabled: false, opacity: self.dimsMock.dim3)
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetToggleStateUseCaseTests {

    func testExecute(
        givenIsEnabled: Bool,
        expectedInteractionState: SwitchToggleState
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for \(givenIsEnabled) givenIsEnabled"

        let useCase = SwitchGetToggleStateUseCase()

        // GIVEN
        let interactionState = useCase.execute(
            forIsEnabled: givenIsEnabled,
            dims: self.dimsMock
        )

        // THEN
        XCTAssertEqual(interactionState.interactionEnabled,
                       expectedInteractionState.interactionEnabled,
                       "Wrong interactionEnabled" + errorPrefixMessage)
        XCTAssertEqual(interactionState.opacity,
                       expectedInteractionState.opacity,
                       "Wrong opacity" + errorPrefixMessage)
    }
}
