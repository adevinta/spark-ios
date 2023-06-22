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

    // MARK: - Tests

    func test_execute_for_all_cases() throws {
        // GIVEN / WHEN
        let statusAndStateColorMock = SwitchStatusColorablesGeneratedMock()
        statusAndStateColorMock.underlyingOnFullColorToken = FullColorTokenGeneratedMock()
        statusAndStateColorMock.underlyingOffFullColorToken = FullColorTokenGeneratedMock()

        let items: [(
            givenIsOn: Bool,
            expectedColorToken: FullColorToken
        )] = [
            (
                givenIsOn: true,
                expectedColorToken: statusAndStateColorMock.onFullColorToken
            ),
            (
                givenIsOn: false,
                expectedColorToken: statusAndStateColorMock.offFullColorToken
            )
        ]

        for item in items {
            let errorPrefixMessage = " for \(item.givenIsOn) isOn"

            let useCase = SwitchGetToggleColorUseCase()
            let colorToken = useCase.execute(
                forIsOn: item.givenIsOn,
                statusAndStateColor: statusAndStateColorMock
            )

            // THEN
            XCTAssertIdentical(colorToken as? ColorTokenGeneratedMock,
                               item.expectedColorToken as? ColorTokenGeneratedMock,
                               "Wrong interactionEnabled" + errorPrefixMessage)
        }
    }
}
