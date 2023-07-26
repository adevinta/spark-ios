//
//  AttributedString+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 26/07/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class AttributedStringExtensionTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_either_when_attributedString_is_set() {
        // GIVEN/WHEN
        let attributedText: AttributedString? = .init("hey")

        // WHEN
        let either = attributedText.either
        
        // THEN
        XCTAssertEqual(either?.rightValue, attributedText, "Wrong either value")
    }

    func test_either_when_attributedString_is_nil() {
        // GIVEN/WHEN
        let attributedText: AttributedString? = nil

        // WHEN
        let either = attributedText.either

        // THEN
        XCTAssertNil(either, "Wrong either value")
    }
}
