//
//  TagGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TagGetColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_variant_cases() throws {
        // GIVEN
        let intentColorsMock = TagIntentColors.mocked()

        let items: [TagGetColors] = [
            .init(
                givenVariant: .filled,
                expectedBackgroundToken: intentColorsMock.color,
                expectedBorderToken: intentColorsMock.color,
                expectedForegroundToken: intentColorsMock.onColor
            ),
            .init(
                givenVariant: .outlined,
                expectedBackgroundToken: intentColorsMock.surfaceColor,
                expectedBorderToken: intentColorsMock.color,
                expectedForegroundToken: intentColorsMock.color
            ),
            .init(
                givenVariant: .tinted,
                expectedBackgroundToken: intentColorsMock.containerColor,
                expectedBorderToken: intentColorsMock.containerColor,
                expectedForegroundToken: intentColorsMock.onContainerColor
            )
        ]

        for item in items {
            let intentColorMock: TagIntentColor = .success

            let themeColorsMock = ColorsGeneratedMock()

            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColorsMock

            let getIntentColorsUseCaseMock = TagGetIntentColorsUseCaseableGeneratedMock()
            getIntentColorsUseCaseMock.executeWithIntentColorAndColorsReturnValue = intentColorsMock

            let useCase = TagGetColorsUseCase(getIntentColorsUseCase: getIntentColorsUseCaseMock)

            // WHEN
            let colors = useCase.execute(
                for: themeMock,
                intentColor: intentColorMock,
                variant: item.givenVariant
            )

            // Other UseCase
            Tester.testGetIntentColorsUseCaseExecuteCalling(
                givenGetIntentColorsUseCase: getIntentColorsUseCaseMock,
                givenIntentColor: intentColorMock,
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
        givenGetIntentColorsUseCase: TagGetIntentColorsUseCaseableGeneratedMock,
        givenIntentColor: TagIntentColor,
        givenThemeColors: ColorsGeneratedMock
    ) {
        let getIntentColorsUseCaseArgs = givenGetIntentColorsUseCase.executeWithIntentColorAndColorsReceivedArguments
        XCTAssertEqual(givenGetIntentColorsUseCase.executeWithIntentColorAndColorsCallsCount,
                       1,
                       "Wrong call number on execute on getIntentColorsUseCase")
        XCTAssertEqual(getIntentColorsUseCaseArgs?.intentColor,
                       givenIntentColor,
                       "Wrong intentColor parameter on execute on getIntentColorsUseCase")
        XCTAssertIdentical(getIntentColorsUseCaseArgs?.colors as? ColorsGeneratedMock,
                           givenThemeColors,
                           "Wrong colors parameter on execute on getIntentColorsUseCase")
    }

    static func testColorsProperties(
        givenColors: TagColors,
        getColors: TagGetColors
    ) throws {
        // Background Color
        try self.testColor(
            givenColorProperty: givenColors.backgroundColor,
            givenPropertyName: "backgroundColor",
            givenVariant: getColors.givenVariant,
            expectedColorToken: getColors.expectedBackgroundToken
        )
        
        // Border Color
        try self.testColor(
            givenColorProperty: givenColors.borderColor,
            givenPropertyName: "borderColor",
            givenVariant: getColors.givenVariant,
            expectedColorToken: getColors.expectedBorderToken
        )

        // Foreground Color
        try self.testColor(
            givenColorProperty: givenColors.foregroundColor,
            givenPropertyName: "foregroundColor",
            givenVariant: getColors.givenVariant,
            expectedColorToken: getColors.expectedForegroundToken
        )
    }

    private static func testColor(
        givenColorProperty: (any ColorToken)?,
        givenPropertyName: String,
        givenVariant: TagVariant,
        expectedColorToken: (any ColorToken)?
    ) throws {
        let errorPrefixMessage = " \(givenPropertyName) for .\(givenVariant) case"

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

private struct TagGetColors {

    let givenVariant: TagVariant

    let expectedBackgroundToken: any ColorToken
    let expectedBorderToken: (any ColorToken)?
    let expectedForegroundToken: any ColorToken
}
