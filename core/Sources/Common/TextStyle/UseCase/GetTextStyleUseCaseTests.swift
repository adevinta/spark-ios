//
//  GetTextStyleUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class GetTextStyleUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_FontTextStyle_for_all_cases() {
        // GIVEN
        let items: [(givenContentSizeCategory: TextStyle, expectedFontTextStyle: Font.TextStyle)] = [
            (.largeTitle, .largeTitle),
            (.title, .title),
            (.title2, .title2),
            (.title3, .title3),
            (.headline, .headline),
            (.subheadline, .subheadline),
            (.body, .body),
            (.callout, .callout),
            (.footnote, .footnote),
            (.caption, .caption),
            (.caption2, .caption2)
        ]

        for item in items {
            let useCase = GetTextStyleUseCase()

            // WHEN
            let textStyle = useCase.execute(from: item.givenContentSizeCategory)

            // THEN
            XCTAssertEqual(textStyle,
                           item.expectedFontTextStyle,
                           "Wrong Font.TextStyle value for .\(item.expectedFontTextStyle) case")
        }
    }

    func test_execute_from_UIFontTextStyle_for_all_cases() {
        // GIVEN / WHEN
        let items: [(givenTextStyle: TextStyle, expectedUIFontTextStyle: UIFont.TextStyle)] = [
            (.largeTitle, .largeTitle),
            (.title, .title1),
            (.title2, .title2),
            (.title3, .title3),
            (.headline, .headline),
            (.subheadline, .subheadline),
            (.body, .body),
            (.callout, .callout),
            (.footnote, .footnote),
            (.caption, .caption1),
            (.caption2, .caption2)
        ]

        for item in items {
            let useCase = GetTextStyleUseCase()

            // WHEN
            let textStyle = useCase.executeForUIFont(from: item.givenTextStyle)

            // THEN
            XCTAssertEqual(textStyle,
                           item.expectedUIFontTextStyle,
                           "Wrong UIFont.TextStyle value for .\(item.expectedUIFontTextStyle) case")
        }
    }
}
