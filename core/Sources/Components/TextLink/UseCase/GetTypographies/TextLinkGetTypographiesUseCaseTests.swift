//
//  TextLinkGetTypographiesUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 06/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TextLinkGetTypographiesUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intents() throws {
        // GIVEN
        let useCase = TextLinkGetTypographiesUseCase()
        let themeMock = ThemeGeneratedMock.mocked()
        let typographyMock = try XCTUnwrap(
            themeMock.typography as? TypographyGeneratedMock,
            "Wrong typography mock type"
        )

        let givenTypographies = TextLinkTypography.allCases

        // WHEN
        for givenTypography in givenTypographies {
            let typographies = useCase.execute(
                typography: givenTypography,
                theme: themeMock
            )

            let expectedTypographies = givenTypography.expectedTypographies(
                from: typographyMock
            )

            // THEN
            XCTAssertEqual(
                typographies,
                expectedTypographies,
                "Wrong typographies for .\(givenTypography) case"
            )
        }
    }
}

// MARK: - Extension

private extension TextLinkTypography {

    func expectedTypographies(from typographyMock: TypographyGeneratedMock) -> TextLinkTypographies {
        switch self {
        case .display1:
            return .init(
                normal: typographyMock.display1,
                highlight: typographyMock.display1
            )
        case .display2:
            return .init(
                normal: typographyMock.display2,
                highlight: typographyMock.display2
            )
        case .display3:
            return .init(
                normal: typographyMock.display3,
                highlight: typographyMock.display3
            )

        case .headline1:
            return .init(
                normal: typographyMock.headline1,
                highlight: typographyMock.headline1
            )
        case .headline2:
            return .init(
                normal: typographyMock.headline2,
                highlight: typographyMock.headline2
            )

        case .subhead:
            return .init(
                normal: typographyMock.subhead,
                highlight: typographyMock.subhead
            )

        case .body1:
            return .init(
                normal: typographyMock.body1,
                highlight: typographyMock.body1Highlight
            )
        case .body2:
            return .init(
                normal: typographyMock.body2,
                highlight: typographyMock.body2Highlight
            )

        case .caption:
            return .init(
                normal: typographyMock.caption,
                highlight: typographyMock.captionHighlight
            )

        case .small:
            return .init(
                normal: typographyMock.small,
                highlight: typographyMock.smallHighlight
            )

        case .callout:
            return .init(
                normal: typographyMock.callout,
                highlight: typographyMock.callout
            )
        }
    }
}
