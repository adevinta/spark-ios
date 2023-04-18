//
//  UIFontTextStyle+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 18/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import UIKit
@testable import SparkCore

final class UIFontTextStyleExtensionTests: XCTestCase {

    // MARK: - Tests

    func test_init_for_all_TextStyle_cases() {
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
            // WHEN
            let textStyle = UIFont.TextStyle(from: item.givenTextStyle)

            // THEN
            XCTAssertEqual(textStyle,
                           item.expectedUIFontTextStyle,
                           "Wrong UIFont.TextStyle value for .\(item.expectedUIFontTextStyle) case")
        }
    }
}
