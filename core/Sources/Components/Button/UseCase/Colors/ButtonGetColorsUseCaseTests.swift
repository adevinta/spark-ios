//
//  ButtonGetColorsUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 24.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_variant_cases() throws {
        // GIVEN
        let intentColorsMock = ButtonColorablesGeneratedMock()
        intentColorsMock.underlyingTextColor  = ColorTokenGeneratedMock.random()
        intentColorsMock.underlyingBackgroundColor = ColorTokenGeneratedMock.random()
        intentColorsMock.underlyingPressedBackgroundColor = ColorTokenGeneratedMock.random()
        intentColorsMock.underlyingBorderColor = ColorTokenGeneratedMock.random()
        intentColorsMock.underlyingPressedBorderColor = ColorTokenGeneratedMock.random()

        let items: [GetColors] = [
            .init(
                givenIntentColor: .primary,
                expectedTextColorToken: intentColorsMock.textColor,
                expectedBackgroundToken: intentColorsMock.backgroundColor,
                expectedPressedBackgroundToken: intentColorsMock.pressedBackgroundColor,
                expectedBorderToken: intentColorsMock.borderColor,
                expectedPressedBorderToken: intentColorsMock.pressedBorderColor
            )
        ]

        for item in items {
            let themeColorsMock = ColorsGeneratedMock()
            themeColorsMock.primary = ColorsPrimaryGeneratedMock.mocked()
            themeColorsMock.states = ColorsStatesGeneratedMock.mocked()

            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColorsMock
            themeMock.underlyingDims = DimsGeneratedMock.mocked()

            let getIntentColorsUseCaseMock = ButtonGetColorsUseCaseableGeneratedMock()
            getIntentColorsUseCaseMock.executeWithThemeAndIntentColorAndVariantReturnValue = intentColorsMock

            // WHEN
            let colors = getIntentColorsUseCaseMock.execute(from: themeMock,
                                         intentColor: item.givenIntentColor,
                                         variant: .filled)

            // Other UseCase
            Tester.testColorsUseCaseExecuteCalling(
                givenColorsUseCase: getIntentColorsUseCaseMock,
                givenIntentColor: item.givenIntentColor,
                givenTheme: themeMock
            )

            // Colors Properties
            try Tester.testColorsProperties(givenColors: colors,
                                            getColors: item)
        }
    }
}

// MARK: - Tester

private struct Tester {

    static func testColorsUseCaseExecuteCalling(
        givenColorsUseCase: ButtonGetColorsUseCaseableGeneratedMock,
        givenIntentColor: ButtonIntentColor,
        givenTheme: ThemeGeneratedMock
    ) {
        let arguments = givenColorsUseCase.executeWithThemeAndIntentColorAndVariantReceivedArguments
        XCTAssertEqual(givenColorsUseCase.executeWithThemeAndIntentColorAndVariantCallsCount,
                       1,
                       "Wrong call number on execute")
        XCTAssertEqual(arguments?.intentColor,
                       givenIntentColor,
                       "Wrong intentColor parameter on execute")
        XCTAssertIdentical(arguments?.theme as? ThemeGeneratedMock,
                           givenTheme,
                           "Wrong theme parameter on execute")
    }

    static func testColorsProperties(
        givenColors: ButtonColorables,
        getColors: GetColors
    ) throws {
        // Text Color
        try self.testColor(
            givenColorProperty: givenColors.textColor,
            givenPropertyName: "textColor",
            givenIntentColor: getColors.givenIntentColor,
            expectedColorToken: getColors.expectedTextColorToken
        )

        // Background Color
        try self.testColor(
            givenColorProperty: givenColors.backgroundColor,
            givenPropertyName: "backgroundColor",
            givenIntentColor: getColors.givenIntentColor,
            expectedColorToken: getColors.expectedBackgroundToken
        )

        // Pressed Background Color
        try self.testColor(
            givenColorProperty: givenColors.pressedBackgroundColor,
            givenPropertyName: "pressedBackgroundColor",
            givenIntentColor: getColors.givenIntentColor,
            expectedColorToken: getColors.expectedPressedBackgroundToken
        )

        // Border Color
        try self.testColor(
            givenColorProperty: givenColors.borderColor,
            givenPropertyName: "borderColor",
            givenIntentColor: getColors.givenIntentColor,
            expectedColorToken: getColors.expectedBorderToken
        )

        // Pressed Border Color
        try self.testColor(
            givenColorProperty: givenColors.pressedBorderColor,
            givenPropertyName: "pressedBorderColor",
            givenIntentColor: getColors.givenIntentColor,
            expectedColorToken: getColors.expectedPressedBorderToken
        )
    }

    private static func testColor(
        givenColorProperty: ColorToken?,
        givenPropertyName: String,
        givenIntentColor: ButtonIntentColor,
        expectedColorToken: ColorToken?
    ) throws {
        let errorPrefixMessage = " \(givenPropertyName) for .\(givenIntentColor) case"

        if let givenColorProperty {
            let color = try XCTUnwrap(givenColorProperty as? ColorTokenGeneratedMock,
                                      "Wrong" + errorPrefixMessage)
            XCTAssertIdentical(color,
                               expectedColorToken as? ColorTokenGeneratedMock,
                               "Wrong value" + errorPrefixMessage)

        } else {
            XCTAssertNil(givenColorProperty,
                         "Should be nil" + errorPrefixMessage)
        }
    }
}

// MARK: - Others Strucs

private struct GetColors {
    let givenIntentColor: ButtonIntentColor

    let expectedTextColorToken: ColorToken
    let expectedBackgroundToken: ColorToken
    let expectedPressedBackgroundToken: ColorToken
    let expectedBorderToken: ColorToken
    let expectedPressedBorderToken: ColorToken
}
