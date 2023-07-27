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
            expectedIconTintColor: self.foregroundColorMock,
            expectedBackgroundColor: self.pressedBackgroundColorMock,
            expectedBorderColor: self.pressedBorderColorMock
        )
    }

    func test_execute_when_isPressed_is_false() throws {
        try self.testExecute(
            givenIsPressed: false,
            expectedIconTintColor: self.foregroundColorMock,
            expectedBackgroundColor: self.backgroundColorMock,
            expectedBorderColor: self.borderColorMock
        )
    }

    // MARK: - DisplayedTextType Tests

    func test_execute_when_displayedTextType_is_none() throws {
        try self.testExecute(
            givenDisplayedTextType: .none,
            expectedTextColor: nil
        )
    }

    func test_execute_when_displayedTextType_is_text() throws {
        try self.testExecute(
            givenDisplayedTextType: .text,
            expectedTextColor: self.foregroundColorMock
        )
    }

    func test_execute_when_displayedTextType_is_attributedText() throws {
        try self.testExecute(
            givenDisplayedTextType: .attributedText,
            expectedTextColor: nil
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetCurrentColorsUseCaseTests {

    func testExecute(
        givenIsPressed: Bool,
        expectedIconTintColor: ColorTokenGeneratedMock,
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
            displayedTextType: .none
        )

        // THEN
        XCTAssertIdentical(currentColors.iconTintColor as? ColorTokenGeneratedMock,
                           expectedIconTintColor,
                           "Wrong iconTintColor" + errorSuffixMessage)
        XCTAssertNil(currentColors.textColor,
                     "Wrong textColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.backgroundColor as? ColorTokenGeneratedMock,
                           expectedBackgroundColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.borderColor as? ColorTokenGeneratedMock,
                           expectedBorderColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
    }

    func testExecute(
        givenDisplayedTextType: DisplayedTextType,
        expectedTextColor: ColorTokenGeneratedMock?
    ) throws {
        // GIVEN
        let errorSuffixMessage = " for \(givenDisplayedTextType) givenDisplayedTextType"

        let useCase = ButtonGetCurrentColorsUseCase()

        // GIVEN
        let currentColors = useCase.execute(
            colors: self.colorsMock,
            isPressed: true,
            displayedTextType: givenDisplayedTextType
        )

        // THEN
        XCTAssertIdentical(currentColors.textColor as? ColorTokenGeneratedMock,
                           expectedTextColor,
                           "Wrong textColor" + errorSuffixMessage)
    }
}
