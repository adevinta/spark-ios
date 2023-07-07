//
//  TagGetContentColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class  TagGetContentColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intent_cases() throws {
        // GIVEN
        let colorsMock = ColorsGeneratedMock.mocked()

        let items: [TagGetContentColors] = [
            .init(
                givenIntent: .alert,
                expectedColor: colorsMock.feedback.alert,
                expectedOnColor: colorsMock.feedback.onAlert,
                expectedContainerColor: colorsMock.feedback.alertContainer,
                expectedOnContainerColor: colorsMock.feedback.onAlertContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .danger,
                expectedColor: colorsMock.feedback.error,
                expectedOnColor: colorsMock.feedback.onError,
                expectedContainerColor: colorsMock.feedback.errorContainer,
                expectedOnContainerColor: colorsMock.feedback.onErrorContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .info,
                expectedColor: colorsMock.feedback.info,
                expectedOnColor: colorsMock.feedback.onInfo,
                expectedContainerColor: colorsMock.feedback.infoContainer,
                expectedOnContainerColor: colorsMock.feedback.onInfoContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .neutral,
                expectedColor: colorsMock.feedback.neutral,
                expectedOnColor: colorsMock.feedback.onNeutral,
                expectedContainerColor: colorsMock.feedback.neutralContainer,
                expectedOnContainerColor: colorsMock.feedback.onNeutralContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .primary,
                expectedColor: colorsMock.primary.primary,
                expectedOnColor: colorsMock.primary.onPrimary,
                expectedContainerColor: colorsMock.primary.primaryContainer,
                expectedOnContainerColor: colorsMock.primary.onPrimaryContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .secondary,
                expectedColor: colorsMock.secondary.secondary,
                expectedOnColor: colorsMock.secondary.onSecondary,
                expectedContainerColor: colorsMock.secondary.secondaryContainer,
                expectedOnContainerColor: colorsMock.secondary.onSecondaryContainer,
                expectedSurfaceColor: colorsMock.base.surface
            ),
            .init(
                givenIntent: .success,
                expectedColor: colorsMock.feedback.success,
                expectedOnColor: colorsMock.feedback.onSuccess,
                expectedContainerColor: colorsMock.feedback.successContainer,
                expectedOnContainerColor: colorsMock.feedback.onSuccessContainer,
                expectedSurfaceColor: colorsMock.base.surface
            )
        ]

        for item in items {

            let useCase = TagGetContentColorsUseCase()

            // WHEN
            let contentColors = useCase.execute(
                for: item.givenIntent,
                colors: colorsMock
            )
            
            //  Content Colors Properties
            try Tester.testContentColorsProperties(
                givenContentColors: contentColors,
                getContentColors: item
            )
        }
    }
}

// MARK: - Tester

private struct Tester {

    static func testContentColorsProperties(
        givenContentColors: TagContentColors,
        getContentColors: TagGetContentColors
    ) throws {
        // Color
        try self.testColor(
            givenColorProperty: givenContentColors.color,
            givenPropertyName: "color",
            givenIntent: getContentColors.givenIntent,
            expectedColorToken: getContentColors.expectedColor
        )
        // On Color
        try self.testColor(
            givenColorProperty: givenContentColors.onColor,
            givenPropertyName: "onColor",
            givenIntent: getContentColors.givenIntent,
            expectedColorToken: getContentColors.expectedOnColor
        )

        // Container Color
        try self.testColor(
            givenColorProperty: givenContentColors.containerColor,
            givenPropertyName: "containerColor",
            givenIntent: getContentColors.givenIntent,
            expectedColorToken: getContentColors.expectedContainerColor
        )

        // On Container Color
        try self.testColor(
            givenColorProperty: givenContentColors.onContainerColor,
            givenPropertyName: "onContainerColor",
            givenIntent: getContentColors.givenIntent,
            expectedColorToken: getContentColors.expectedOnContainerColor
        )

        // Surface Color
        try self.testColor(
            givenColorProperty: givenContentColors.surfaceColor,
            givenPropertyName: "surfaceColor",
            givenIntent: getContentColors.givenIntent,
            expectedColorToken: getContentColors.expectedSurfaceColor
        )
    }

    private static func testColor(
        givenColorProperty: any ColorToken,
        givenPropertyName: String,
        givenIntent: TagIntent,
        expectedColorToken: any ColorToken
    ) throws {
        let errorPrefixMessage = " \(givenPropertyName) for .\(givenIntent) case"

        let color = try XCTUnwrap(givenColorProperty as? ColorTokenGeneratedMock,
                                  "Wrong" + errorPrefixMessage)
        XCTAssertIdentical(color,
                           expectedColorToken as? ColorTokenGeneratedMock,
                           "Wrong value" + errorPrefixMessage)
    }
}

// MARK: - Others Strucs

private struct TagGetContentColors {

    let givenIntent: TagIntent

    let expectedColor: any ColorToken
    let expectedOnColor: any ColorToken
    let expectedContainerColor: any ColorToken
    let expectedOnContainerColor: any ColorToken
    let expectedSurfaceColor: any ColorToken
}
