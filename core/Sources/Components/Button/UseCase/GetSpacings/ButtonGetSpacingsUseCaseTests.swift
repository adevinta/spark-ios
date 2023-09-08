//
//  ButtonGetSpacingsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetSpacingsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_when_isOnlyIcon_is_true() {
        // GIVEN
        let spacingMock = LayoutSpacingGeneratedMock.mocked()
        
        let useCase = ButtonGetSpacingsUseCase()

        // WHEN
        let spacings = useCase.execute(
            spacing: spacingMock,
            isOnlyIcon: true
        )

        // THEN
        XCTAssertEqual(spacings.verticalSpacing,
                       0,
                       "Wrong verticalSpacing value")
        XCTAssertEqual(spacings.horizontalSpacing,
                       0,
                       "Wrong horizontalSpacing value")
        XCTAssertEqual(spacings.horizontalPadding,
                       0,
                       "Wrong horizontalPadding value")
    }

    func test_execute_when_isOnlyIcon_is_false() {
        // GIVEN
        let spacingMock = LayoutSpacingGeneratedMock.mocked()

        let useCase = ButtonGetSpacingsUseCase()

        // WHEN
        let spacings = useCase.execute(
            spacing: spacingMock,
            isOnlyIcon: false
        )

        // THEN
        XCTAssertEqual(spacings.verticalSpacing,
                       spacingMock.medium,
                       "Wrong verticalSpacing value")
        XCTAssertEqual(spacings.horizontalSpacing,
                       spacingMock.large,
                       "Wrong horizontalSpacing value")
        XCTAssertEqual(spacings.horizontalPadding,
                       spacingMock.medium,
                       "Wrong horizontalPadding value")
    }
}
