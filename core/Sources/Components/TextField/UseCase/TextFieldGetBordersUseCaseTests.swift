//
//  TextFieldGetBordersUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by Jacklyn Situmorang on 17.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class TextFieldGetBordersUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let themeMock = ThemeGeneratedMock.mocked()

    // MARK: - Tests

    func test_execute_for_none() {
        self.testExecute(
            givenBorderStyle: .none,
            expectedBorder: .init(
                radius: .zero,
                width: .zero, 
                widthWhenActive: .zero
            ))
    }

    func test_execute_for_roundedRect() {
        self.testExecute(
            givenBorderStyle: .roundedRect,
            expectedBorder: .init(
                radius: themeMock.border.radius.large,
                width: themeMock.border.width.small,
                widthWhenActive: themeMock.border.width.medium
            ))
    }
}

// MARK: - Extension

private extension TextFieldGetBordersUseCaseTests {
    func testExecute(
        givenBorderStyle: TextFieldBorderStyle,
        expectedBorder: TextFieldBorders
    ) {
        // GIVEN
        let useCase = TextFieldGetBordersUseCase()

        // WHEN
        let textFieldBorders = useCase.execute(
            theme: self.themeMock,
            borderStyle: givenBorderStyle
        )

        // THEN
        XCTAssertEqual(textFieldBorders.radius, expectedBorder.radius)
        XCTAssertEqual(textFieldBorders.width, expectedBorder.width)
    }
}
