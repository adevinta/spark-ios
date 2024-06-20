//
//  DisplayedTextTypeTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class DisplayedTextTypeTests: XCTestCase {

    // MARK: - Tests

    func test_containsText_when_type_is_none() {
        // GIVEN
        let type: DisplayedTextType = .none

        // WHEN
        let containsText = type.containsText

        // THEN
        XCTAssertFalse(containsText)
    }

    func test_containsText_when_type_is_text() {
        // GIVEN
        let type: DisplayedTextType = .text

        // WHEN
        let containsText = type.containsText

        // THEN
        XCTAssertTrue(containsText)
    }

    func test_containsText_when_type_is_attributedText() {
        // GIVEN
        let type: DisplayedTextType = .attributedText

        // WHEN
        let containsText = type.containsText

        // THEN
        XCTAssertTrue(containsText)
    }
}
