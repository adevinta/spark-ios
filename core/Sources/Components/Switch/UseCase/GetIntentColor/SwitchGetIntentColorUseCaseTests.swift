//
//  SwitchGetIntentColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetIntentColorUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_SwitchIntentColor_cases() throws {
        // GIVEN / WHEN
        let colorsMock = ColorsGeneratedMock.mocked()

        let items: [(givenIntentColor: SwitchIntentColor, expectedColorToken: ColorToken)] = [
            (.alert, colorsMock.feedback.alert),
            (.error, colorsMock.feedback.error),
            (.info, colorsMock.feedback.info),
            (.neutral, colorsMock.feedback.neutral),
            (.primary, colorsMock.primary.primary),
            (.secondary, colorsMock.secondary.secondary),
            (.success, colorsMock.feedback.success)
        ]

        for item in items {
            let useCase = SwitchGetIntentColorUseCase()

            let colorToken = useCase.execute(
                forIntentColor: item.givenIntentColor,
                colors: colorsMock
            )

            // THEN
            XCTAssertIdentical(colorToken as? ColorTokenGeneratedMock,
                               item.expectedColorToken as? ColorTokenGeneratedMock,
                               "Wrong color for .\(item.givenIntentColor) case")
        }
    }
}
