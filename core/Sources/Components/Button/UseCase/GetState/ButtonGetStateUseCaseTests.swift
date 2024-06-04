//
//  ButtonGetStateUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class ButtonGetStateUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let dimsMock = DimsGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_isEnabled_is_true() {
        self.testExecute(
            givenIsEnabled: true,
            expectedIsInteractionState: .init(isUserInteractionEnabled: true, opacity: self.dimsMock.none)
        )
    }

    func test_execute_when_isEnabled_is_false() {
        self.testExecute(
            givenIsEnabled: false,
            expectedIsInteractionState: .init(isUserInteractionEnabled: false, opacity: self.dimsMock.dim3)
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetStateUseCaseTests {

    func testExecute(
        givenIsEnabled: Bool,
        expectedIsInteractionState: ButtonState
    ) {
        // GIVEN
        let errorSuffixMessage = " for \(givenIsEnabled) givenIsEnabled"

        let useCase = ButtonGetStateUseCase()

        // GIVEN
        let interactionState = useCase.execute(
            isEnabled: givenIsEnabled,
            dims: self.dimsMock
        )

        // THEN
        XCTAssertEqual(interactionState.isUserInteractionEnabled,
                       expectedIsInteractionState.isUserInteractionEnabled,
                       "Wrong isUserInteractionEnabled" + errorSuffixMessage)
        XCTAssertEqual(interactionState.opacity,
                       expectedIsInteractionState.opacity,
                       "Wrong opacity" + errorSuffixMessage)
    }
}
