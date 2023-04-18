//
//  FontTextStyle+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class FontTextStyleExtensionTests: XCTestCase {

    // MARK: - Tests

    func test_init_for_all_TextStyle_cases() {
        // GIVEN
        let items: [(givenTextStyle: TextStyle, expectedFontTextStyle: Font.TextStyle)] = [
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
            // WHEN
            let textStyle = Font.TextStyle(from: item.givenTextStyle)

            // THEN
            XCTAssertEqual(textStyle,
                           item.expectedFontTextStyle,
                           "Wrong Font.TextStyle value for .\(item.expectedFontTextStyle) case")
        }
    }
}
