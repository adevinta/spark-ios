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

        let getIntentColorUseCaseMock = SwitchGetIntentColorUseCaseableGeneratedMock()
        getIntentColorUseCaseMock.executeWithIntentColorAndColorsReturnValue = intentColorTokenMock

        let useCase = SwitchGetColorsUseCase(getIntentColorUseCase: getIntentColorUseCaseMock)

        // WHEN
        let colors = useCase.execute(for: .alert, on: colorsMock)

        // **
        // Background colors
        XCTAssertIdentical(
            colors.backgroundColors.onAndSelectedColor as? ColorTokenGeneratedMock,
            intentColorTokenMock,
            "Wrong onAndSelectedColor color on backgroundColors"
        )
        XCTAssertIdentical(
            colors.backgroundColors.onAndUnselectedColor as? ColorTokenGeneratedMock,
            colorsMock.base.onSurface as? ColorTokenGeneratedMock,
            "Wrong onAndUnselectedColor color on backgroundColors"
        )
        XCTAssertIdentical(
            colors.backgroundColors.offAndSelectedColor as? ColorTokenGeneratedMock,
            intentColorTokenMock,
            "Wrong offAndSelectedColor color on backgroundColors"
        )
        XCTAssertIdentical(
            colors.backgroundColors.offAndUnselectedColor as? ColorTokenGeneratedMock,
            colorsMock.feedback.neutralContainer as? ColorTokenGeneratedMock,
            "Wrong offAndUnselectedColor color on backgroundColors"
        )
        // **

        XCTAssertIdentical(
            colors.statusBackgroundColor as? ColorTokenGeneratedMock,
            colorsMock.base.surface as? ColorTokenGeneratedMock,
            "Wrong statusBackgroundColor color"
        )

        // **
        // State foreground colors
        XCTAssertIdentical(
            colors.statusForegroundColors.onAndSelectedColor as? ColorTokenGeneratedMock,
            intentColorTokenMock,
            "Wrong onAndSelectedColor color on statusForegroundColors"
        )
        XCTAssertIdentical(
            colors.statusForegroundColors.onAndUnselectedColor as? ColorTokenGeneratedMock,
            colorsMock.base.onSurface as? ColorTokenGeneratedMock,
            "Wrong onAndUnselectedColor color on statusForegroundColors"
        )
        XCTAssertIdentical(
            colors.statusForegroundColors.offAndSelectedColor as? ColorTokenGeneratedMock,
            intentColorTokenMock,
            "Wrong offAndSelectedColor color on statusForegroundColors"
        )
        XCTAssertIdentical(
            colors.statusForegroundColors.offAndUnselectedColor as? ColorTokenGeneratedMock,
            colorsMock.feedback.neutralContainer as? ColorTokenGeneratedMock,
            "Wrong offAndUnselectedColor color on statusForegroundColors"
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
