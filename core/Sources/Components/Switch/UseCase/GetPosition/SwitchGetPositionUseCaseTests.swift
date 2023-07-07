//
//  SwitchGetPositionUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetPositionUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let spacingMock = LayoutSpacingGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_when_switchAlignment_is_left_case() throws {
        try self.testExecute(
            givenAlignment: .left,
            expectedPosition: .init(
                isToggleOnLeft: true,
                horizontalSpacing: self.spacingMock.medium
            )
        )
    }

    func test_execute_when_switchAlignment_is_right_case() throws {
        try self.testExecute(
            givenAlignment: .left,
            expectedPosition: .init(
                isToggleOnLeft: true,
                horizontalSpacing: self.spacingMock.medium
            )
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetPositionUseCaseTests {

    func testExecute(
        givenAlignment: SwitchAlignment,
        expectedPosition: SwitchPositionDefault
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for .\(givenAlignment) case"

        let useCase = SwitchGetPositionUseCase()

        // WHEN
        let position = useCase.execute(
            forAlignment: givenAlignment,
            spacing: self.spacingMock
        )

        // THEN
        XCTAssertEqual(position.isToggleOnLeft,
                       expectedPosition.isToggleOnLeft,
                       "Wrong isToggleOnLeft position" + errorPrefixMessage)
        XCTAssertEqual(position.horizontalSpacing,
                       expectedPosition.horizontalSpacing,
                       "Wrong horizontalSpacing position" + errorPrefixMessage)
    }
}
