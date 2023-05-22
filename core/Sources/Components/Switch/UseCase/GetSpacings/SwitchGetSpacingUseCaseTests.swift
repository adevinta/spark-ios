//
//  SwitchGetSpacingUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetSpacingUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_SwitchAlignment_cases() throws {
        // GIVEN / WHEN
        let spacingMock = LayoutSpacingGeneratedMock.mocked()

        let items: [(givenAlignment: SwitchAlignment, expectedSpacing: SwitchSpacing)] = [
            (.left, .init(horizontal: spacingMock.medium, vertical: spacingMock.xLarge)),
            (.right, .init(horizontal: spacingMock.xxxLarge, vertical: spacingMock.xLarge)),
        ]

        for item in items {
            let errorPrefixMessage = " for .\(item.givenAlignment) case"

            let useCase = SwitchGetSpacingUseCase()
            let spacing = useCase.execute(
                for: item.givenAlignment,
                on: spacingMock
            )

            // THEN
            XCTAssertEqual(spacing.horizontal,
                           item.expectedSpacing.horizontal,
                           "Wrong horizontal spacing" + errorPrefixMessage)
            XCTAssertEqual(spacing.vertical,
                           item.expectedSpacing.vertical,
                           "Wrong vertical spacing" + errorPrefixMessage)
        }
    }
}
