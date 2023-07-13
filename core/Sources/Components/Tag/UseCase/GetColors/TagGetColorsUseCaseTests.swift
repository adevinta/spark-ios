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
        let contentColorsMock = TagContentColors.mocked()

        let items: [TagGetColors] = [
            .init(
                givenVariant: .filled,
                expectedBackgroundToken: contentColorsMock.color,
                expectedBorderToken: contentColorsMock.color,
                expectedForegroundToken: contentColorsMock.onColor
            ),
            .init(
                givenVariant: .outlined,
                expectedBackgroundToken: contentColorsMock.surfaceColor,
                expectedBorderToken: contentColorsMock.color,
                expectedForegroundToken: contentColorsMock.color
            ),
            .init(
                givenVariant: .tinted,
                expectedBackgroundToken: contentColorsMock.containerColor,
                expectedBorderToken: contentColorsMock.containerColor,
                expectedForegroundToken: contentColorsMock.onContainerColor
            )
        ]

        for item in items {
            let intentMock: TagIntent = .success

            let themeColorsMock = ColorsGeneratedMock()

            let themeMock = ThemeGeneratedMock()
            themeMock.underlyingColors = themeColorsMock

            let getContentColorsUseCaseMock = TagGetContentColorsUseCaseableGeneratedMock()
            getContentColorsUseCaseMock.executeWithIntentAndColorsReturnValue = contentColorsMock

            let useCase = TagGetColorsUseCase(getContentColorsUseCase: getContentColorsUseCaseMock)

            // WHEN
            let colors = useCase.execute(
                theme: themeMock,
                intent: intentMock,
                variant: item.givenVariant
            )

            // Other UseCase
            Tester.testGetContentColorsUseCaseExecuteCalling(
                givenGetContentColorsUseCase: getContentColorsUseCaseMock,
                givenIntent: intentMock,
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

    static func testGetContentColorsUseCaseExecuteCalling(
        givenGetContentColorsUseCase: TagGetContentColorsUseCaseableGeneratedMock,
        givenIntent: TagIntent,
        givenThemeColors: ColorsGeneratedMock
    ) {
        let getContentColorsUseCaseArgs = givenGetContentColorsUseCase.executeWithIntentAndColorsReceivedArguments
        XCTAssertEqual(givenGetContentColorsUseCase.executeWithIntentAndColorsCallsCount,
                       1,
                       "Wrong call number on execute on getContentColorsUseCase")
        XCTAssertEqual(getContentColorsUseCaseArgs?.intent,
                       givenIntent,
                       "Wrong intent parameter on execute on getContentColorsUseCase")
        XCTAssertIdentical(getContentColorsUseCaseArgs?.colors as? ColorsGeneratedMock,
                           givenThemeColors,
                           "Wrong colors parameter on execute on getContentColorsUseCase")
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
