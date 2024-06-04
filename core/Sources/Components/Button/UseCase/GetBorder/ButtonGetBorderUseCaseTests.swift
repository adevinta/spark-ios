//
//  ButtonGetBorderUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 23/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class ButtonGetBorderUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let borderMock = BorderGeneratedMock.mocked()

    // MARK: - Tests Radius from all shapes cases

    func test_execute_radius_when_shape_is_square_case() {
        self.testExecute(
            givenShape: .square,
            expectedRadius: 0
        )
    }

    func test_execute_radius_when_shape_is_rounded_case() {
        self.testExecute(
            givenShape: .rounded,
            expectedRadius: self.borderMock.radius.large
        )
    }

    func test_execute_radius_when_shape_is_pill_case() {
        self.testExecute(
            givenShape: .pill,
            expectedRadius: self.borderMock.radius.full
        )
    }

    // MARK: - Tests Width drom all variants cases

    func test_execute_width_when_variant_is_contrast_case() {
        self.testExecute(
            givenVariant: .contrast,
            expectedWidth: 0
        )
    }

    func test_execute_width_when_variant_is_filled_case() {
        self.testExecute(
            givenVariant: .filled,
            expectedWidth: 0
        )
    }

    func test_execute_width_when_variant_is_ghost_case() {
        self.testExecute(
            givenVariant: .ghost,
            expectedWidth: 0
        )
    }

    func test_execute_width_when_variant_is_outlined_case() {
        self.testExecute(
            givenVariant: .outlined,
            expectedWidth: self.borderMock.width.small
        )
    }

    func test_execute_width_when_variant_is_tinted_case() {
        self.testExecute(
            givenVariant: .tinted,
            expectedWidth: 0
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetBorderUseCaseTests {

    func testExecute(
        givenShape: ButtonShape,
        expectedRadius: CGFloat
    ) {
        // GIVEN
        let errorSuffixMessage = " for .\(givenShape) shape case"

        let useCase = ButtonGetBorderUseCase()

        // WHEN
        let border = useCase.execute(
            shape: givenShape,
            border: self.borderMock,
            variant: .filled
        )

        // THEN
        XCTAssertEqual(border.radius,
                       expectedRadius,
                       "Wrong radius" + errorSuffixMessage)
    }

    func testExecute(
        givenVariant: ButtonVariant,
        expectedWidth: CGFloat
    ) {
        // GIVEN
        let errorSuffixMessage = " for .\(givenVariant) variant case"

        let useCase = ButtonGetBorderUseCase()

        // WHEN
        let border = useCase.execute(
            shape: .pill,
            border: self.borderMock,
            variant: givenVariant
        )

        // THEN
        XCTAssertEqual(border.width,
                       expectedWidth,
                       "Wrong width" + errorSuffixMessage)
    }
}
