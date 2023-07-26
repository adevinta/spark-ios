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
            let intentsMock = ButtonColors.mocked()

            return GetColors(
                givenIntent: .primary,
                givenVariant: $0,
                givenColors: intentsMock,
                expectedforegroundColorToken: intentsMock.foregroundColor,
                expectedBackgroundToken: intentsMock.backgroundColor,
                expectedPressedBackgroundToken: intentsMock.pressedBackgroundColor,
                expectedBorderToken: intentsMock.borderColor,
                expectedPressedBorderToken: intentsMock.pressedBorderColor
            )
        }

        for item in items {
            let themeColorsMock = ColorsGeneratedMock()
            themeColorsMock.main = ColorsMainGeneratedMock.mocked()
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
            mockedUseCase.executeWithIntentAndColorsAndDimsReturnValue = item.givenColors

            let getIntentsUseCaseMock = ButtonGetColorsUseCase(
                getContrastUseCase: getContrastUseCaseMock,
                getFilledUseCase: getFilledUseCaseMock,
                getGhostUseCase: getGhostUseCaseMock,
                getOutlinedUseCase: getOutlinedUseCaseMock,
                getTintedUseCase: getTintedUseCaseMock
            )

            // WHEN
            let colors = getIntentsUseCaseMock.execute(
                theme: themeMock,
                intent: item.givenIntent,
                variant: item.givenVariant
            )

            // Other UseCase
            Tester.testColorsUseCaseExecuteCalling(
                givenColorsUseCase: mockedUseCase,
                givenIntent: item.givenIntent,
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
        givenIntent: ButtonIntent,
        givenColors: ColorsGeneratedMock,
        givenDims: DimsGeneratedMock
    ) {
        let arguments = givenColorsUseCase.executeWithIntentAndColorsAndDimsReceivedArguments
        XCTAssertEqual(givenColorsUseCase.executeWithIntentAndColorsAndDimsCallsCount,
                       1,
                       "Wrong call number on execute")
        XCTAssertEqual(arguments?.intent,
                       givenIntent,
                       "Wrong intent parameter on execute")
        XCTAssertIdentical(arguments?.colors as? ColorsGeneratedMock,
                           givenColors,
                           "Wrong colors parameter on execute")
        XCTAssertIdentical(arguments?.dims as? DimsGeneratedMock,
                           givenDims,
                           "Wrong dims parameter on execute")
    }

    static func testColorsProperties(
        givenColors: ButtonColors,
        getColors: GetColors
    ) throws {
        // Text Color
        try self.testColor(
            givenColorProperty: givenColors.foregroundColor,
            givenPropertyName: "foregroundColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedforegroundColorToken
        )

        // Background Color
        try self.testColor(
            givenColorProperty: givenColors.backgroundColor,
            givenPropertyName: "backgroundColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedBackgroundToken
        )

        // Pressed Background Color
        try self.testColor(
            givenColorProperty: givenColors.pressedBackgroundColor,
            givenPropertyName: "pressedBackgroundColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedPressedBackgroundToken
        )

        // Border Color
        try self.testColor(
            givenColorProperty: givenColors.borderColor,
            givenPropertyName: "borderColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedBorderToken
        )

        // Pressed Border Color
        try self.testColor(
            givenColorProperty: givenColors.pressedBorderColor,
            givenPropertyName: "pressedBorderColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedPressedBorderToken
        )
    }

    private static func testColor(
        givenColorProperty: (any ColorToken)?,
        givenPropertyName: String,
        givenIntent: ButtonIntent,
        expectedColorToken: (any ColorToken)?
    ) throws {
        let errorSuffixMessage = " \(givenPropertyName) for .\(givenIntent) case"

        if let givenColorProperty {
            let color = try XCTUnwrap(givenColorProperty as? ColorTokenGeneratedMock,
                                      "Wrong" + errorSuffixMessage)
            XCTAssertIdentical(color,
                               expectedColorToken as? ColorTokenGeneratedMock,
                               "Wrong value" + errorSuffixMessage)

        } else {
            XCTAssertNil(givenColorProperty,
                         "Should be nil" + errorSuffixMessage)
        }
    }
}

// MARK: - Others Strucs

private struct GetColors {
    let givenIntent: ButtonIntent
    let givenVariant: ButtonVariant
    let givenColors: ButtonColors

    let expectedforegroundColorToken: any ColorToken
    let expectedBackgroundToken: any ColorToken
    let expectedPressedBackgroundToken: any ColorToken
    let expectedBorderToken: any ColorToken
    let expectedPressedBorderToken: any ColorToken
}
