//
//  CheckboxColorsUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class CheckboxColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_variant_cases() throws {
        // GIVEN
        let intentColorsMock = CheckboxStateColorablesGeneratedMock()
        intentColorsMock.underlyingTextColor = ColorTokenGeneratedMock()
        intentColorsMock.underlyingPressedBorderColor = ColorTokenGeneratedMock()
        intentColorsMock.underlyingCheckboxColor = ColorTokenGeneratedMock()
        intentColorsMock.underlyingCheckboxIconColor = ColorTokenGeneratedMock()

        let items: [GetColors] = [
            .init(
                givenState: .enabled,
                expectedTextColorToken: intentColorsMock.textColor,
                expectedPressedBorderToken: intentColorsMock.pressedBorderColor,
                expectedCheckboxTintToken: intentColorsMock.checkboxColor,
                expectedCheckboxIconToken: intentColorsMock.checkboxIconColor
            )
        ]

        for item in items {
            let themeColorsMock = ColorsGeneratedMock()

            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColorsMock

            let getIntentColorsUseCaseMock = CheckboxStateColorsUseCaseableGeneratedMock()
            getIntentColorsUseCaseMock.executeWithIntentColorAndColorsReturnValue = intentColorsMock

            let useCase = CheckboxColorsUseCase(stateColorsUseCase: getIntentColorsUseCaseMock)

            // WHEN
            let colors = useCase.execute(from: themeMock,
                                         state: item.givenState)

            // Other UseCase
            Tester.testGetIntentColorsUseCaseExecuteCalling(
                givenGetIntentColorsUseCase: getIntentColorsUseCaseMock,
                givenState: item.givenState,
                givenThemeColors: themeColorsMock
            )

            // Colors Properties
            try Tester.testColorsProperties(givenColors: colors,
                                            getColors: item)
        }
    }
}

// MARK: - Tester

private struct Tester {

    static func testGetIntentColorsUseCaseExecuteCalling(
        givenGetIntentColorsUseCase: CheckboxStateColorsUseCaseableGeneratedMock,
        givenState: SelectButtonState,
        givenThemeColors: ColorsGeneratedMock
    ) {
        let getIntentColorsUseCaseArgs = givenGetIntentColorsUseCase.executeWithIntentColorAndColorsReceivedArguments
        XCTAssertEqual(givenGetIntentColorsUseCase.executeWithIntentColorAndColorsCallsCount,
                       1,
                       "Wrong call number on execute on getIntentColorsUseCase")
        XCTAssertEqual(getIntentColorsUseCaseArgs?.intentColor,
                       givenState,
                       "Wrong intentColor parameter on execute on getIntentColorsUseCase")
        XCTAssertIdentical(getIntentColorsUseCaseArgs?.colors as? ColorsGeneratedMock,
                           givenThemeColors,
                           "Wrong colors parameter on execute on getIntentColorsUseCase")
    }

    static func testColorsProperties(
        givenColors: CheckboxColorables,
        getColors: GetColors
    ) throws {
        // Text Color
        try self.testColor(
            givenColorProperty: givenColors.textColor,
            givenPropertyName: "textColor",
            givenState: getColors.givenState,
            expectedColorToken: getColors.expectedTextColorToken
        )

        // Checkbox Icon Color
        try self.testColor(
            givenColorProperty: givenColors.checkboxIconColor,
            givenPropertyName: "checkboxIconColor",
            givenState: getColors.givenState,
            expectedColorToken: getColors.expectedCheckboxIconToken
        )

        // Checkbox Tint Color
        try self.testColor(
            givenColorProperty: givenColors.checkboxTintColor,
            givenPropertyName: "checkboxTintColor",
            givenState: getColors.givenState,
            expectedColorToken: getColors.expectedCheckboxTintToken
        )

        // Pressed Border Color
        try self.testColor(
            givenColorProperty: givenColors.pressedBorderColor,
            givenPropertyName: "pressedBorderColor",
            givenState: getColors.givenState,
            expectedColorToken: getColors.expectedPressedBorderToken
        )
    }

    private static func testColor(
        givenColorProperty: (any ColorToken)?,
        givenPropertyName: String,
        givenState: SelectButtonState,
        expectedColorToken: (any ColorToken)?
    ) throws {
        let errorPrefixMessage = " \(givenPropertyName) for .\(givenState) case"

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
    let givenState: SelectButtonState

    let expectedTextColorToken: any ColorToken
    let expectedPressedBorderToken: (any ColorToken)?
    let expectedCheckboxTintToken: any ColorToken
    let expectedCheckboxIconToken: any ColorToken
}
