//
//  SwitchGetColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 12/05/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class SwitchGetColorUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute() throws {
        // GIVEN
        let intentColorMock = SwitchIntentColor.alert
        let intentColorTokenMock = ColorTokenGeneratedMock.random()

        let colorsMock = ColorsGeneratedMock.mocked()
        let dimsMock = DimsGeneratedMock.mocked()

        let getIntentColorUseCaseMock = SwitchGetIntentColorUseCaseableGeneratedMock()
        getIntentColorUseCaseMock.executeWithIntentColorAndColorsReturnValue = intentColorTokenMock

        let expectedOnColorToken = FullColorTokenDefault(colorToken: intentColorTokenMock, opacity: 1)
        let expectedOffColorToken = FullColorTokenDefault(colorToken: colorsMock.base.onSurface, opacity: dimsMock.dim4)

        let useCase = SwitchGetColorsUseCase(getIntentColorUseCase: getIntentColorUseCaseMock)

        // WHEN

        let colors = useCase.execute(
            forIntentColor: intentColorMock,
            colors: colorsMock,
            dims: dimsMock
        )

        // **
        // Status background colors
        XCTAssertEqual(
            colors.toggleBackgroundColors.onColorToken as? FullColorTokenDefault,
            expectedOnColorToken,
            "Wrong onColorToken on toggleBackgroundColors"
        )
        XCTAssertEqual(
            colors.toggleBackgroundColors.offColorToken as? FullColorTokenDefault,
            expectedOffColorToken,
            "Wrong offColorToken on toggleBackgroundColors"
        )
        // **

        XCTAssertIdentical(
            colors.toggleDotBackgroundColor as? ColorTokenGeneratedMock,
            colorsMock.base.surface as? ColorTokenGeneratedMock,
            "Wrong toggleBackgroundColor color"
        )

        // **
        // State foreground colors
        XCTAssertEqual(
            colors.toggleDotForegroundColors.onColorToken as? FullColorTokenDefault,
            expectedOnColorToken,
            "Wrong onColorToken on toggleDotForegroundColors"
        )
        XCTAssertEqual(
            colors.toggleDotForegroundColors.offColorToken as? FullColorTokenDefault,
            expectedOffColorToken,
            "Wrong offColorToken on toggleDotForegroundColors"
        )
        // **

        XCTAssertIdentical(
            colors.textForegroundColor as? ColorTokenGeneratedMock,
            colorsMock.base.onSurface as? ColorTokenGeneratedMock,
            "Wrong textForegroundColor color"
        )
        
        // **
        // GetIntentColorUseCase
        let getIntentColorUseCaseArgs = getIntentColorUseCaseMock.executeWithIntentColorAndColorsReceivedArguments
        XCTAssertEqual(
            getIntentColorUseCaseMock.executeWithIntentColorAndColorsCallsCount,
            1,
            "Wrong call number on execute on getIntentColorUseCase"
        )
        XCTAssertEqual(
            getIntentColorUseCaseArgs?.intentColor,
            intentColorMock,
            "Wrong intentColor parameter on execute on getIntentColorUseCaseMock"
        )
        XCTAssertIdentical(
            getIntentColorUseCaseArgs?.colors as? ColorsGeneratedMock,
            colorsMock,
            "Wrong colors parameter on execute on getIntentColorUseCaseMock"
        )
        // **
    }
}
