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
        let variants: [ButtonVariant] = [.filled, .outlined, .contrast, .tinted, .ghost]
        let items = variants.map {
            let intentColorsMock = ButtonColorablesGeneratedMock()
            intentColorsMock.underlyingTextColor = ColorTokenGeneratedMock.random()
            intentColorsMock.underlyingBackgroundColor = ColorTokenGeneratedMock.random()
            intentColorsMock.underlyingPressedBackgroundColor = ColorTokenGeneratedMock.random()
            intentColorsMock.underlyingBorderColor = ColorTokenGeneratedMock.random()
            intentColorsMock.underlyingPressedBorderColor = ColorTokenGeneratedMock.random()

            return GetColors(
                givenIntentColor: .primary,
                givenVariant: $0,
                givenColorables: intentColorsMock,
                expectedTextColorToken: intentColorsMock.textColor,
                expectedBackgroundToken: intentColorsMock.backgroundColor,
                expectedPressedBackgroundToken: intentColorsMock.pressedBackgroundColor,
                expectedBorderToken: intentColorsMock.borderColor,
                expectedPressedBorderToken: intentColorsMock.pressedBorderColor
            )
        }

        for item in items {
            let themeColorsMock = ColorsGeneratedMock()
            themeColorsMock.primary = ColorsPrimaryGeneratedMock.mocked()
            themeColorsMock.states = ColorsStatesGeneratedMock.mocked()

            let dimsMock = DimsGeneratedMock.mocked()
            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColorsMock
            themeMock.underlyingDims = dimsMock

            let getContrastUseCaseMock = ButtonGetVariantUseCaseableGeneratedMock()
            let getFilledUseCaseMock = ButtonGetVariantUseCaseableGeneratedMock()
            let getGhostUseCaseMock = ButtonGetVariantUseCaseableGeneratedMock()
            let getOutlinedUseCaseMock = ButtonGetVariantUseCaseableGeneratedMock()
            let getTintedUseCaseMock = ButtonGetVariantUseCaseableGeneratedMock()

            let mockedUseCase: ButtonGetVariantUseCaseableGeneratedMock
            switch item.givenVariant {
            case .contrast:
                mockedUseCase = getContrastUseCaseMock
            case .filled:
                mockedUseCase = getFilledUseCaseMock
            case .ghost:
                mockedUseCase = getGhostUseCaseMock
            case .outlined:
                mockedUseCase = getOutlinedUseCaseMock
            case .tinted:
                mockedUseCase = getTintedUseCaseMock
            }
            mockedUseCase.colorsWithIntentColorAndColorsAndDimsReturnValue = item.givenColorables

            let getIntentColorsUseCaseMock = ButtonGetColorsUseCase(
                getContrastUseCase: getContrastUseCaseMock,
                getFilledUseCase: getFilledUseCaseMock,
                getGhostUseCase: getGhostUseCaseMock,
                getOutlinedUseCase: getOutlinedUseCaseMock,
                getTintedUseCase: getTintedUseCaseMock
            )

            // WHEN
            let colors = getIntentColorsUseCaseMock.execute(
                forTheme: themeMock,
                intentColor: item.givenIntentColor,
                variant: item.givenVariant
            )

            // Other UseCase
            Tester.testColorsUseCaseExecuteCalling(
                givenColorsUseCase: mockedUseCase,
                givenIntentColor: item.givenIntentColor,
                givenColors: themeColorsMock,
                givenDims: dimsMock
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
        givenColorsUseCase: ButtonGetVariantUseCaseableGeneratedMock,
        givenIntentColor: ButtonIntentColor,
        givenColors: ColorsGeneratedMock,
        givenDims: DimsGeneratedMock
    ) {
        let arguments = givenColorsUseCase.colorsWithIntentColorAndColorsAndDimsReceivedArguments
        XCTAssertEqual(givenColorsUseCase.colorsWithIntentColorAndColorsAndDimsCallsCount,
                       1,
                       "Wrong call number on execute")
        XCTAssertEqual(arguments?.intentColor,
                       givenIntentColor,
                       "Wrong intentColor parameter on execute")
        XCTAssertIdentical(arguments?.colors as? ColorsGeneratedMock,
                           givenColors,
                           "Wrong colors parameter on execute")
        XCTAssertIdentical(arguments?.dims as? DimsGeneratedMock,
                           givenDims,
                           "Wrong dims parameter on execute")
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
        givenColorProperty: (any ColorToken)?,
        givenPropertyName: String,
        givenIntentColor: ButtonIntentColor,
        expectedColorToken: (any ColorToken)?
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
    let givenVariant: ButtonVariant
    let givenColorables: ButtonColorablesGeneratedMock

    let expectedTextColorToken: any ColorToken
    let expectedBackgroundToken: any ColorToken
    let expectedPressedBackgroundToken: any ColorToken
    let expectedBorderToken: any ColorToken
    let expectedPressedBorderToken: any ColorToken
}
