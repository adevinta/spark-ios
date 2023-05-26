//
//  UIEdgeInsets+ExtensionsTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class UIEdgeInsetsExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_init_all() {
        // GIVEN/WHEN
        let edgetInsets = UIEdgeInsets(all: 99)

        // THEN
        XCTAssertEqual(edgetInsets.top, 99, "Wrong top value")
        XCTAssertEqual(edgetInsets.left, 99, "Wrong left value")
        XCTAssertEqual(edgetInsets.bottom, 99, "Wrong bottom value")
        XCTAssertEqual(edgetInsets.right, 99, "Wrong right value")
    }

    func test_init_vertical_and_horizontal() {
        // GIVEN/WHEN
        let edgetInsets = UIEdgeInsets(vertical: 13, horizontal: 44)

        // THEN
        XCTAssertEqual(edgetInsets.top, 13, "Wrong top value")
        XCTAssertEqual(edgetInsets.left, 44, "Wrong left value")
        XCTAssertEqual(edgetInsets.bottom, 13, "Wrong bottom value")
        XCTAssertEqual(edgetInsets.right, 44, "Wrong right value")
    }
}
