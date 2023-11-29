//
//  ButtonGetCurrentColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 27/06/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetCurrentColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    private let foregroundColorMock = ColorTokenGeneratedMock()
    private let backgroundColorMock = ColorTokenGeneratedMock()
    private let pressedBackgroundColorMock = ColorTokenGeneratedMock()
    private let borderColorMock = ColorTokenGeneratedMock()
    private let pressedBorderColorMock = ColorTokenGeneratedMock()

    private lazy var colorsMock: ButtonColors = {
        return .init(
            foregroundColor: self.foregroundColorMock,
            backgroundColor: self.backgroundColorMock,
            pressedBackgroundColor: self.pressedBackgroundColorMock,
            borderColor: self.borderColorMock,
            pressedBorderColor: self.pressedBorderColorMock
        )
    }()

    // MARK: - IsPressed Tests

    func test_execute_when_isPressed_is_true() throws {
        try self.testExecute(
            givenIsPressed: true,
            expectedImageTintColor: self.foregroundColorMock,
            expectedTitleColor: self.foregroundColorMock,
            expectedBackgroundColor: self.pressedBackgroundColorMock,
            expectedBorderColor: self.pressedBorderColorMock
        )
    }

    func test_execute_when_isPressed_is_false() throws {
        try self.testExecute(
            givenIsPressed: false,
            expectedImageTintColor: self.foregroundColorMock,
            expectedTitleColor: self.foregroundColorMock,
            expectedBackgroundColor: self.backgroundColorMock,
            expectedBorderColor: self.borderColorMock
        )
    }

    func test_deprecated_execute_when_isPressed_is_true() throws {
        try self.testDeprecatedExecute(
            givenIsPressed: true,
            expectedImageTintColor: self.foregroundColorMock,
            expectedBackgroundColor: self.pressedBackgroundColorMock,
            expectedBorderColor: self.pressedBorderColorMock
        )
    }

    func test_deprecated_execute_when_isPressed_is_false() throws {
        try self.testDeprecatedExecute(
            givenIsPressed: false,
            expectedImageTintColor: self.foregroundColorMock,
            expectedBackgroundColor: self.backgroundColorMock,
            expectedBorderColor: self.borderColorMock
        )
    }

    // MARK: - DisplayedTitleType Tests

    func test_deprecated_execute_when_displayedTitleType_is_none() throws {
        try self.testDeprecatedExecute(
            givenDisplayedTitleType: .none,
            expectedTitleColor: nil
        )
    }

    func test_deprecated_execute_when_displayedTitleType_is_title() throws {
        try self.testDeprecatedExecute(
            givenDisplayedTitleType: .text,
            expectedTitleColor: self.foregroundColorMock
        )
    }

    func test_deprecated_execute_when_displayedTitleType_is_attributedTitle() throws {
        try self.testDeprecatedExecute(
            givenDisplayedTitleType: .attributedText,
            expectedTitleColor: nil
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetCurrentColorsUseCaseTests {

    func testExecute(
        givenIsPressed: Bool,
        expectedImageTintColor: ColorTokenGeneratedMock,
        expectedTitleColor: ColorTokenGeneratedMock,
        expectedBackgroundColor: ColorTokenGeneratedMock,
        expectedBorderColor: ColorTokenGeneratedMock
    ) throws {
        // GIVEN
        let errorSuffixMessage = " for \(givenIsPressed) givenIsPressed"

        let useCase = ButtonGetCurrentColorsUseCase()

        // GIVEN
        let currentColors = useCase.execute(
            colors: self.colorsMock,
            isPressed: givenIsPressed
        )

        // THEN
        XCTAssertIdentical(currentColors.imageTintColor as? ColorTokenGeneratedMock,
                           expectedImageTintColor,
                           "Wrong imageTintColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.titleColor as? ColorTokenGeneratedMock,
                           expectedTitleColor,
                           "Wrong titleColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.backgroundColor as? ColorTokenGeneratedMock,
                           expectedBackgroundColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.borderColor as? ColorTokenGeneratedMock,
                           expectedBorderColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
    }

    func testDeprecatedExecute(
        givenIsPressed: Bool,
        expectedImageTintColor: ColorTokenGeneratedMock,
        expectedBackgroundColor: ColorTokenGeneratedMock,
        expectedBorderColor: ColorTokenGeneratedMock
    ) throws {
        // GIVEN
        let errorSuffixMessage = " for \(givenIsPressed) givenIsPressed"

        let useCase = ButtonGetCurrentColorsUseCase()

        // GIVEN
        let currentColors = useCase.execute(
            colors: self.colorsMock,
            isPressed: givenIsPressed,
            displayedTitleType: .none
        )

        // THEN
        XCTAssertIdentical(currentColors.imageTintColor as? ColorTokenGeneratedMock,
                           expectedImageTintColor,
                           "Wrong imageTintColor" + errorSuffixMessage)
        XCTAssertNil(currentColors.titleColor,
                     "Wrong titleColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.backgroundColor as? ColorTokenGeneratedMock,
                           expectedBackgroundColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.borderColor as? ColorTokenGeneratedMock,
                           expectedBorderColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
    }

    func testDeprecatedExecute(
        givenDisplayedTitleType: DisplayedTextType,
        expectedTitleColor: ColorTokenGeneratedMock?
    ) throws {
        // GIVEN
        let errorSuffixMessage = " for \(givenDisplayedTitleType) givenDisplayedTitleType"

        let useCase = ButtonGetCurrentColorsUseCase()

        // GIVEN
        let currentColors = useCase.execute(
            colors: self.colorsMock,
            isPressed: true,
            displayedTitleType: givenDisplayedTitleType
        )

        // THEN
        XCTAssertIdentical(currentColors.titleColor as? ColorTokenGeneratedMock,
                           expectedTitleColor,
                           "Wrong titleColor" + errorSuffixMessage)
    }
}
