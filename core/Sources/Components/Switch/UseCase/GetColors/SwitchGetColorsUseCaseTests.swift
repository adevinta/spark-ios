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

        let expectedOnFullColorToken = FullColorTokenDefault(colorToken: intentColorTokenMock, opacity: 1)
        let expectedOffFullColorToken = FullColorTokenDefault(colorToken: colorsMock.base.onSurface, opacity: dimsMock.dim4)

        let useCase = SwitchGetColorsUseCase(getIntentColorUseCase: getIntentColorUseCaseMock)

        // WHEN

        let colors = useCase.execute(
            forIntentColor: .alert,
            colors: colorsMock,
            dims: dimsMock
        )

        // **
        // Status background colors
        XCTAssertEqual(
            colors.toggleBackgroundColors.onFullColorToken as? FullColorTokenDefault,
            expectedOnFullColorToken,
            "Wrong onFullColorToken on toggleBackgroundColors"
        )
        XCTAssertEqual(
            colors.toggleBackgroundColors.offFullColorToken as? FullColorTokenDefault,
            expectedOffFullColorToken,
            "Wrong offFullColorToken on toggleBackgroundColors"
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
            colors.toggleDotForegroundColors.onFullColorToken as? FullColorTokenDefault,
            expectedOnFullColorToken,
            "Wrong onFullColorToken on toggleDotForegroundColors"
        )
        XCTAssertEqual(
            colors.toggleDotForegroundColors.offFullColorToken as? FullColorTokenDefault,
            expectedOffFullColorToken,
            "Wrong offFullColorToken on toggleDotForegroundColors"
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
