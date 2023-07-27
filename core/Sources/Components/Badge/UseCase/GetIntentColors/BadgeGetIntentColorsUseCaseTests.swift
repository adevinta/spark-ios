//
//  BadgeGetColorsUseCaseTests.swift
//  SparkDemo
//
//  Created by alex.vecherov on 15.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class BadgeGetColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_variant_cases() throws {
        // Given

        let mockedExpectedColors = ColorsGeneratedMock.mocked()
        let mockedExpectedSurfaceColor = mockedExpectedColors.base.surface

        let items: [BadgeGetColors] = [
            .init(
                givenIntent: .alert,
                expectedBackgroundToken: mockedExpectedColors.feedback.alert,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.feedback.onAlert
            ),
            .init(
                givenIntent: .danger,
                expectedBackgroundToken: mockedExpectedColors.feedback.error,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.feedback.onError
            ),
            .init(
                givenIntent: .info,
                expectedBackgroundToken: mockedExpectedColors.feedback.info,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.feedback.onInfo
            ),
            .init(
                givenIntent: .neutral,
                expectedBackgroundToken: mockedExpectedColors.feedback.neutral,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.feedback.onNeutral
            ),
            .init(
                givenIntent: .main,
                expectedBackgroundToken: mockedExpectedColors.main.main,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.main.onMain
            ),
            .init(
                givenIntent: .support,
                expectedBackgroundToken: mockedExpectedColors.support.support,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.support.onSupport
            ),
            .init(
                givenIntent: .success,
                expectedBackgroundToken: mockedExpectedColors.feedback.success,
                expectedBorderToken: mockedExpectedSurfaceColor,
                expectedTextToken: mockedExpectedColors.feedback.onSuccess
            )
        ]

        for item in items {
            let useCase = BadgeGetIntentColorsUseCase()

            // When
            let colors = useCase.execute(intentType: item.givenIntent, on: mockedExpectedColors)

            try Tester.testColorsProperties(
                givenColors: colors,
                getColors: item
            )
        }
    }
}

private struct Tester {

    static func testColorsProperties(
        givenColors: BadgeColors,
        getColors: BadgeGetColors
    ) throws {
        // Background Color
        try self.testColor(
            givenColorProperty: givenColors.backgroundColor,
            givenPropertyName: "backgroundColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedBackgroundToken
        )

        // Border Color
        try self.testColor(
            givenColorProperty: givenColors.borderColor,
            givenPropertyName: "borderColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedBorderToken
        )

        // Foreground Color
        try self.testColor(
            givenColorProperty: givenColors.foregroundColor,
            givenPropertyName: "foregroundColor",
            givenIntent: getColors.givenIntent,
            expectedColorToken: getColors.expectedTextToken
        )
    }

    private static func testColor(
        givenColorProperty: (any ColorToken)?,
        givenPropertyName: String,
        givenIntent: BadgeIntentType,
        expectedColorToken: (any ColorToken)?
    ) throws {
        let errorPrefixMessage = "\(givenPropertyName) for .\(givenIntent) case"

        if let givenColorProperty {
            let color = try XCTUnwrap(givenColorProperty as? ColorTokenGeneratedMock, "Wrong " + errorPrefixMessage)
            XCTAssertIdentical(color, expectedColorToken as? ColorTokenGeneratedMock, "Wrong value " + errorPrefixMessage)
        } else {
            XCTAssertNil(givenColorProperty, "Should be nil" + errorPrefixMessage)
        }
    }
}

private struct BadgeGetColors {
    let givenIntent: BadgeIntentType

    let expectedBackgroundToken: any ColorToken
    let expectedBorderToken: any ColorToken
    let expectedTextToken: any ColorToken
}
