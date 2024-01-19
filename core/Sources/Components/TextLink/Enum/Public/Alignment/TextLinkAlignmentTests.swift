//
//  TextLinkAlignmentTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 08/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class TextLinkAlignmentTests: XCTestCase {

    // MARK: - Tests

    func test_isTrailingImage_for_all_cases() {
        // GIVEN
        let items: [(givenAlignment: TextLinkAlignment, expectedIsTrailingImage: Bool)] = [
            (givenAlignment: .leadingImage, expectedIsTrailingImage: false),
            (givenAlignment: .trailingImage, expectedIsTrailingImage: true)
        ]

        for item in items {
            // WHEN
            let isTrailingImage = item.givenAlignment.isTrailingImage

            // THEN
            XCTAssertEqual(
                isTrailingImage,
                item.expectedIsTrailingImage,
                "Wrong isTrailingImage for .\(item.givenAlignment) cases"
            )
        }
    }
}
