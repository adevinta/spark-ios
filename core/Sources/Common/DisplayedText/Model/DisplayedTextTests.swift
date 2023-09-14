//
//  DisplayedTextTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class DisplayedTextTests: XCTestCase {
    
    // MARK: - Optional Init
    
    func test_optional_init_with_only_text() {
        // GIVEN
        let textMock = "My text"

        // WHEN
        let displayedText = DisplayedText(
            text: textMock,
            attributedText: nil
        )

        // THEN
        XCTAssertEqual(
            displayedText?.text,
            textMock,
            "Wrong text"
        )
        XCTAssertNil(
            displayedText?.attributedText,
            "Wrong attributedText"
        )
    }

    func test_optional_init_with_only_attributedText() {
        // GIVEN
        let attributedMock: AttributedStringEither = .left(.init(string: "Holà"))

        // WHEN
        let displayedText = DisplayedText(
            text: nil,
            attributedText: attributedMock
        )

        // THEN
        XCTAssertNil(
            displayedText?.text,
            "Wrong text"
        )
        XCTAssertEqual(
            displayedText?.attributedText,
            attributedMock,
            "Wrong attributedText"
        )
    }

    func test_optional_init_without_text_and_attributedText() {
        // GIVEN / WHEN
        let displayedText = DisplayedText(
            text: nil,
            attributedText: nil
        )

        // THEN
        XCTAssertNil(
            displayedText,
            "Wrong displayedText"
        )
    }

    // MARK: - Text Init

    func test_init_with_text() {
        // GIVEN
        let textMock = "My text"

        // WHEN
        let displayedText = DisplayedText(
            text: textMock
        )

        // THEN
        XCTAssertEqual(
            displayedText.text,
            textMock,
            "Wrong text"
        )
        XCTAssertNil(
            displayedText.attributedText,
            "Wrong attributedText"
        )
    }

    // MARK: - AttributedText Init

    func test_init_with_attributedText() {
        // GIVEN
        let attributedMock: AttributedStringEither = .left(.init(string: "Holà"))

        // WHEN
        let displayedText = DisplayedText(
            attributedText: attributedMock
        )

        // THEN
        XCTAssertNil(
            displayedText.text,
            "Wrong text"
        )
        XCTAssertEqual(
            displayedText.attributedText,
            attributedMock,
            "Wrong attributedText"
        )
    }
}
