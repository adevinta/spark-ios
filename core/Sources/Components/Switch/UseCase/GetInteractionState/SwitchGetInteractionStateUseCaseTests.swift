//
//  SwitchGetInteractionStateUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetInteractionStateUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_SwitchState_cases() throws {
        // GIVEN / WHEN
        let dimsMock = DimsGeneratedMock.mocked()

        let items: [(
            givenAlignment: SwitchState,
            givenIsOn: Bool,
            expectedInteractionState: SwitchInteractionState
        )] = [
            // **
            // Enabled
            (.enabled,
             true,
             .init(interactionEnabled: true, opacity: 1)
            ),
            (.enabled,
             false,
             .init(interactionEnabled: true, opacity: dimsMock.dim4)
            ),
            // **

            // **
            // Disabled
            (.disabled,
             true,
             .init(interactionEnabled: false, opacity: dimsMock.dim3)
            ),
            (.disabled,
             false,
             .init(interactionEnabled: false, opacity: 1)
            )
            // **
        ]

        for item in items {
            let errorPrefixMessage = " for .\(item.givenAlignment) case and \(item.givenIsOn) isOn"

            let useCase = SwitchGetInteractionStateUseCase()
            let interactionState = useCase.execute(
                for: item.givenAlignment,
                isOn: item.givenIsOn,
                on: dimsMock
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
