//
//  TextFieldGetBorderLayoutUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 01/02/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class TextFieldGetBorderLayoutUseCaseTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_roundedRect_isFocused() {
        // GIVEN
        let useCase = TextFieldGetBorderLayoutUseCase()
        let borderStyle = TextFieldBorderStyle.roundedRect
        let isFocused = true

        // WHEN
        let borderLayout = useCase.execute(
            theme: self.theme,
            borderStyle: borderStyle,
            isFocused: isFocused
        )

        // THEN
        XCTAssertEqual(borderLayout.radius, self.theme.border.radius.large, "Wrong radius")
        XCTAssertEqual(borderLayout.width, self.theme.border.width.medium, "Wrong width")
    }

    func test_roundedRect_isNotFocused() {
        // GIVEN
        let useCase = TextFieldGetBorderLayoutUseCase()
        let borderStyle = TextFieldBorderStyle.roundedRect
        let isFocused = false

        // WHEN
        let borderLayout = useCase.execute(
            theme: self.theme,
            borderStyle: borderStyle,
            isFocused: isFocused
        )

        // THEN
        XCTAssertEqual(borderLayout.radius, self.theme.border.radius.large, "Wrong radius")
        XCTAssertEqual(borderLayout.width, self.theme.border.width.small, "Wrong width")
    }

    func test_none_isFocused() {
        // GIVEN
        let useCase = TextFieldGetBorderLayoutUseCase()
        let borderStyle = TextFieldBorderStyle.none
        let isFocused = true

        // WHEN
        let borderLayout = useCase.execute(
            theme: self.theme,
            borderStyle: borderStyle,
            isFocused: isFocused
        )

        // THEN
        XCTAssertEqual(borderLayout.radius, self.theme.border.radius.none, "Wrong radius")
        XCTAssertEqual(borderLayout.width, self.theme.border.width.none, "Wrong width")
    }

    func test_none_isNotFocused() {
        // GIVEN
        let useCase = TextFieldGetBorderLayoutUseCase()
        let borderStyle = TextFieldBorderStyle.none
        let isFocused = false

        // WHEN
        let borderLayout = useCase.execute(
            theme: self.theme,
            borderStyle: borderStyle,
            isFocused: isFocused
        )

        // THEN
        XCTAssertEqual(borderLayout.radius, self.theme.border.radius.none, "Wrong radius")
        XCTAssertEqual(borderLayout.width, self.theme.border.width.none, "Wrong width")
    }
}
