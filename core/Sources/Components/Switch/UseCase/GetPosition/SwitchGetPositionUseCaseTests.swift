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
import SparkThemingTesting

final class SwitchGetPositionUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let spacingMock = LayoutSpacingGeneratedMock.mocked()

    // MARK: - Alignment Tests

    func test_execute_when_switchAlignment_is_left_case() throws {
        try self.testExecute(
            givenAlignment: .left,
            givenContainsText: true,
            expectedPosition: .init(
                isToggleOnLeft: true,
                horizontalSpacing: self.spacingMock.medium
            )
        )
    }

    func test_execute_when_switchAlignment_is_right_case() throws {
        try self.testExecute(
            givenAlignment: .left,
            givenContainsText: true,
            expectedPosition: .init(
                isToggleOnLeft: true,
                horizontalSpacing: self.spacingMock.medium
            )
        )
    }

    // MARK: - Contains Text Tests

    func test_execute_when_containsText_is_false() throws {
        try self.testExecute(
            givenAlignment: .left,
            givenContainsText: false,
            expectedPosition: .init(
                isToggleOnLeft: true,
                horizontalSpacing: 0
            )
        )
    }
}

// MARK: - Execute Testing

private extension SwitchGetPositionUseCaseTests {

    func testExecute(
        givenAlignment: SwitchAlignment,
        givenContainsText: Bool,
        expectedPosition: SwitchPosition
    ) throws {
        // GIVEN
        let errorPrefixMessage = " for .\(givenAlignment) alignment case - containsText = .\(givenContainsText)"

        let useCase = SwitchGetPositionUseCase()

        // WHEN
        let position = useCase.execute(
            alignment: givenAlignment,
            spacing: self.spacingMock,
            containsText: givenContainsText
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
