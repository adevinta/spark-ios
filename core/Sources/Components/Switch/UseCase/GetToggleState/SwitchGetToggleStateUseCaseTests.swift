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

    // MARK: - Tests

    func test_execute_for_all_cases() throws {
        // GIVEN / WHEN
        let dimsMock = DimsGeneratedMock.mocked()

        let items: [(
            givenIsEnabled: Bool,
            expectedInteractionState: SwitchToggleState
        )] = [
            (
                givenIsEnabled: true,
                expectedInteractionState: .init(interactionEnabled: true, opacity: 1)
            ),
            (
                givenIsEnabled: false,
                expectedInteractionState: .init(interactionEnabled: false, opacity: dimsMock.dim3)
            )
        ]

        for item in items {
            let errorPrefixMessage = " for \(item.givenIsEnabled) givenIsEnabled"

            let useCase = SwitchGetToggleStateUseCase()
            let interactionState = useCase.execute(
                forIsEnabled: item.givenIsEnabled,
                dims: dimsMock
            )

            // THEN
            XCTAssertEqual(interactionState.interactionEnabled,
                           item.expectedInteractionState.interactionEnabled,
                           "Wrong interactionEnabled" + errorPrefixMessage)
            XCTAssertEqual(interactionState.opacity,
                           item.expectedInteractionState.opacity,
                           "Wrong opacity" + errorPrefixMessage)
        }
    }
}
