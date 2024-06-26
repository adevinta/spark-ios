//
//  PopoverIntentTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 26/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class PopoverIntentTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()

    func test_internal_getColors() throws {
        // GIVEN
        let useCaseMock = PopoverGetColorsUseCasableGeneratedMock()
        useCaseMock.executeWithColorsAndIntentReturnValue = .init(
            background: self.theme.colors.feedback.alert,
            foreground: self.theme.colors.main.onMain
        )

        // WHEN
        let colors = PopoverIntent.alert.getColors(theme: self.theme, getColorsUseCase: useCaseMock)

        // THEN - Values
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.alert), "Wrong background color")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.main.onMain), "Wrong foreground color")

        // THEN - UseCase
        XCTAssertEqual(useCaseMock.executeWithColorsAndIntentCallsCount, 1, "useCaseMock.executeWithColorsAndIntent should have been called once")
        let receivedArguments = try XCTUnwrap(useCaseMock.executeWithColorsAndIntentReceivedArguments)
        XCTAssertIdentical(
            receivedArguments.colors as? ColorsGeneratedMock,
            self.theme.colors as? ColorsGeneratedMock,
            "Wrong receivedArguments.colors"
        )
        XCTAssertEqual(receivedArguments.intent, .alert, "Wrong receivedArguments.intent")
    }

    func test_used_getColorsUseCase() {
        for intent in PopoverIntent.allCases {
            XCTAssertTrue(intent.getColorsUseCase is PopoverGetColorsUseCase, "Wrong getColorsUseCase type for intent \(intent)")
        }
    }

}
