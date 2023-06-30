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

    private lazy var colorsMock: ButtonColorsGeneratedMock = {
        let mock = ButtonColorsGeneratedMock()
        mock.underlyingForegroundColor = self.foregroundColorMock
        mock.underlyingBackgroundColor = self.backgroundColorMock
        mock.underlyingPressedBackgroundColor = self.pressedBackgroundColorMock
        mock.underlyingBorderColor = self.borderColorMock
        mock.underlyingPressedBorderColor = self.pressedBorderColorMock
        return mock
    }()

    // MARK: - Tests

    func test_execute_when_isPressed_is_true() throws {
        try self.testExecute(
            givenIsPressed: true,
            expectedForegroundColor: self.foregroundColorMock,
            expectedBackgroundColor: self.pressedBackgroundColorMock,
            expectedBorderColor: self.pressedBorderColorMock
        )
    }

    func test_execute_when_isPressed_is_false() throws {
        try self.testExecute(
            givenIsPressed: false,
            expectedForegroundColor: self.foregroundColorMock,
            expectedBackgroundColor: self.backgroundColorMock,
            expectedBorderColor: self.borderColorMock
        )
    }
}

// MARK: - Execute Testing

private extension ButtonGetCurrentColorsUseCaseTests {

    func testExecute(
        givenIsPressed: Bool,
        expectedForegroundColor: ColorTokenGeneratedMock,
        expectedBackgroundColor: ColorTokenGeneratedMock,
        expectedBorderColor: ColorTokenGeneratedMock
    ) throws {
        // GIVEN
        let errorSuffixMessage = " for \(givenIsPressed) givenIsPressed"

        let useCase = ButtonGetCurrentColorsUseCase()

        // GIVEN
        let currentColors = useCase.execute(
            forColors: self.colorsMock,
            isPressed: givenIsPressed
        )

        // THEN
        XCTAssertIdentical(currentColors.foregroundColor as? ColorTokenGeneratedMock,
                           expectedForegroundColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.backgroundColor as? ColorTokenGeneratedMock,
                           expectedBackgroundColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
        XCTAssertIdentical(currentColors.borderColor as? ColorTokenGeneratedMock,
                           expectedBorderColor,
                           "Wrong foregroundColor" + errorSuffixMessage)
    }
}
