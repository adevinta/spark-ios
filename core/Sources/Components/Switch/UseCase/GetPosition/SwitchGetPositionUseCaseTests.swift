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

    // MARK: - Tests

    func test_execute_for_all_switchAlignment_cases() throws {
        // GIVEN / WHEN
        let spacingMock = LayoutSpacingGeneratedMock.mocked()

        let items: [(
            givenAlignment: SwitchAlignment,
            expectedPosition: SwitchPosition
        )] = [
            (
                givenAlignment: .left,
                expectedPosition: .init(isToggleOnLeft: true, horizontalSpacing: spacingMock.medium)
            ),
            (
                givenAlignment: .right,
                expectedPosition: .init(isToggleOnLeft: false, horizontalSpacing: spacingMock.xxxLarge)
            )
        ]

        for item in items {
            let errorPrefixMessage = " for .\(item.givenAlignment) case"

            let useCase = SwitchGetPositionUseCase()
            let position = useCase.execute(
                forAlignment: item.givenAlignment,
                spacing: spacingMock
            )

            // THEN
            XCTAssertEqual(position.isToggleOnLeft,
                           item.expectedPosition.isToggleOnLeft,
                           "Wrong isToggleOnLeft position" + errorPrefixMessage)
            XCTAssertEqual(position.horizontalSpacing,
                           item.expectedPosition.horizontalSpacing,
                           "Wrong horizontalSpacing position" + errorPrefixMessage)
        }
    }
}
