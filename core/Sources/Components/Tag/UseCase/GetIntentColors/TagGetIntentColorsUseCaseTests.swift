//
//  TagGetIntentColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class  TagGetIntentColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intentColor_cases() throws {
        // GIVEN
        let colorsMock = ColorsGeneratedMock.mocked()

        let items: [TagGetIntentColors] = [
            .init(
                givenIntentColor: .alert,
                expectedColor: colorsMock.feedback.alert,
                expectedOnColor: colorsMock.feedback.onAlert,
                expectedContainerColor: colorsMock.feedback.alertContainer,
                expectedOnContainerColor: colorsMock.feedback.onAlertContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .danger,
                expectedColor: colorsMock.feedback.error,
                expectedOnColor: colorsMock.feedback.onError,
                expectedContainerColor: colorsMock.feedback.errorContainer,
                expectedOnContainerColor: colorsMock.feedback.onErrorContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .info,
                expectedColor: colorsMock.feedback.info,
                expectedOnColor: colorsMock.feedback.onInfo,
                expectedContainerColor: colorsMock.feedback.infoContainer,
                expectedOnContainerColor: colorsMock.feedback.onInfoContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .neutral,
                expectedColor: colorsMock.feedback.neutral,
                expectedOnColor: colorsMock.feedback.onNeutral,
                expectedContainerColor: colorsMock.feedback.neutralContainer,
                expectedOnContainerColor: colorsMock.feedback.onNeutralContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .primary,
                expectedColor: colorsMock.primary.primary,
                expectedOnColor: colorsMock.primary.onPrimary,
                expectedContainerColor: colorsMock.primary.primaryContainer,
                expectedOnContainerColor: colorsMock.primary.onPrimaryContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .secondary,
                expectedColor: colorsMock.secondary.secondary,
                expectedOnColor: colorsMock.secondary.onSecondary,
                expectedContainerColor: colorsMock.secondary.secondaryContainer,
                expectedOnContainerColor: colorsMock.secondary.onSecondaryContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntentColor: .success,
                expectedColor: colorsMock.feedback.success,
                expectedOnColor: colorsMock.feedback.onSuccess,
                expectedContainerColor: colorsMock.feedback.successContainer,
                expectedOnContainerColor: colorsMock.feedback.onSuccessContainer,
                expectedSurfaceColor: colorsMock.base.surface
            )
        ]

        for item in items {

            let useCase = TagGetIntentColorsUseCase()

            // WHEN
            let intentColors = useCase.execute(forIntentColor: item.givenIntentColor,
                                               colors: colorsMock)

            //  Intent Colors Properties
            try Tester.testColorsProperties(givenIntentColors: intentColors,
                                            getIntentColors: item)
        }
    }
}

// MARK: - Tester

private struct Tester {

    static func testColorsProperties(
        givenIntentColors: TagIntentColorables,
        getIntentColors: TagGetIntentColors
    ) throws {
        // Color
        try self.testColor(
            givenColorProperty: givenIntentColors.color,
            givenPropertyName: "color",
            givenIntentColor: getIntentColors.givenIntentColor,
            expectedColorToken: getIntentColors.expectedColor
        )
        // On Color
        try self.testColor(
            givenColorProperty: givenIntentColors.onColor,
            givenPropertyName: "onColor",
            givenIntentColor: getIntentColors.givenIntentColor,
            expectedColorToken: getIntentColors.expectedOnColor
        )

        // Container Color
        try self.testColor(
            givenColorProperty: givenIntentColors.containerColor,
            givenPropertyName: "containerColor",
            givenIntentColor: getIntentColors.givenIntentColor,
            expectedColorToken: getIntentColors.expectedContainerColor
        )

        // On Container Color
        try self.testColor(
            givenColorProperty: givenIntentColors.onContainerColor,
            givenPropertyName: "onContainerColor",
            givenIntentColor: getIntentColors.givenIntentColor,
            expectedColorToken: getIntentColors.expectedOnContainerColor
        )

        // Surface Color
        try self.testColor(
            givenColorProperty: givenIntentColors.surfaceColor,
            givenPropertyName: "surfaceColor",
            givenIntentColor: getIntentColors.givenIntentColor,
            expectedColorToken: getIntentColors.expectedSurfaceColor
        )
    }

    private static func testColor(
        givenColorProperty: any ColorToken,
        givenPropertyName: String,
        givenIntentColor: TagIntentColor,
        expectedColorToken: any ColorToken
    ) throws {
        let errorPrefixMessage = " \(givenPropertyName) for .\(givenIntentColor) case"

        let color = try XCTUnwrap(givenColorProperty as? ColorTokenGeneratedMock,
                                  "Wrong" + errorPrefixMessage)
        XCTAssertIdentical(color,
                           expectedColorToken as? ColorTokenGeneratedMock,
                           "Wrong value" + errorPrefixMessage)
    }
}

// MARK: - Others Strucs

private struct TagGetIntentColors {

    let givenIntentColor: TagIntentColor

    let expectedColor: any ColorToken
    let expectedOnColor: any ColorToken
    let expectedContainerColor: any ColorToken
    let expectedOnContainerColor: any ColorToken
    let expectedSurfaceColor: any ColorToken
}
