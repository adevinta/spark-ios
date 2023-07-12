//
//  SwitchGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute() throws {
        // GIVEN
        let intentMock = SwitchIntent.alert
        let colorTokenMock = ColorTokenGeneratedMock.random()

        let colorsMock = ColorsGeneratedMock.mocked()
        let dimsMock = DimsGeneratedMock.mocked()

        let getColorUseCaseMock = SwitchGetColorUseCaseableGeneratedMock()
        getColorUseCaseMock.executeWithIntentAndColorsReturnValue = colorTokenMock

        let expectedOnColorToken = colorTokenMock
        let expectedOffColorToken = colorsMock.base.onSurface.opacity(dimsMock.dim4)

        let useCase = SwitchGetColorsUseCase(getColorUseCase: getColorUseCaseMock)

        // WHEN

        let colors = useCase.execute(
            for: intentMock,
            colors: colorsMock,
            dims: dimsMock
        )

        // **
        // Status background colors
        XCTAssertEqual(
            colors.toggleBackgroundColors.onColorToken.hashValue,
            expectedOnColorToken.hashValue,
            "Wrong onColorToken on toggleBackgroundColors"
        )
        XCTAssertEqual(
            colors.toggleBackgroundColors.offColorToken.hashValue,
            expectedOffColorToken.hashValue,
            "Wrong offColorToken on toggleBackgroundColors"
        )
        // **

        XCTAssertEqual(
            colors.toggleDotBackgroundColor.hashValue,
            colorsMock.base.surface.hashValue,
            "Wrong toggleBackgroundColor color"
        )

        // **
        // State foreground colors
        XCTAssertEqual(
            colors.toggleDotForegroundColors.onColorToken.hashValue,
            expectedOnColorToken.hashValue,
            "Wrong onColorToken on toggleDotForegroundColors"
        )
        XCTAssertEqual(
            colors.toggleDotForegroundColors.offColorToken.hashValue,
            expectedOffColorToken.hashValue,
            "Wrong offColorToken on toggleDotForegroundColors"
        )
        // **

        XCTAssertEqual(
            colors.textForegroundColor.hashValue,
            colorsMock.base.onSurface.hashValue,
            "Wrong textForegroundColor color"
        )

        // **
        // GetColorUseCase
        let getColorUseCaseArgs = getColorUseCaseMock.executeWithIntentAndColorsReceivedArguments
        XCTAssertEqual(
            getColorUseCaseMock.executeWithIntentAndColorsCallsCount,
            1,
            "Wrong call number on execute on getColorUseCase"
        )
        XCTAssertEqual(
            getColorUseCaseArgs?.intent,
            intentMock,
            "Wrong intent parameter on execute on getColorUseCaseMock"
        )
        XCTAssertIdentical(
            getColorUseCaseArgs?.colors as? ColorsGeneratedMock,
            colorsMock,
            "Wrong colors parameter on execute on getColorUseCaseMock"
        )
        // **
    }
}
