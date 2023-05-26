//
//  EdgeInsets+ExtensionTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class EdgeInsetsExtensionsTests: XCTestCase {

    // MARK: - Tests

    func test_init_all() {
        // GIVEN/WHEN
        let edgetInsets = EdgeInsets(all: 99)

        // THEN
        XCTAssertEqual(edgetInsets.top, 99, "Wrong top value")
        XCTAssertEqual(edgetInsets.leading, 99, "Wrong leading value")
        XCTAssertEqual(edgetInsets.bottom, 99, "Wrong bottom value")
        XCTAssertEqual(edgetInsets.trailing, 99, "Wrong trailing value")
    }

    func test_init_vertical_and_horizontal() {
        // GIVEN/WHEN
        let edgetInsets = EdgeInsets(vertical: 13, horizontal: 44)

        // THEN
        XCTAssertEqual(edgetInsets.top, 13, "Wrong top value")
        XCTAssertEqual(edgetInsets.leading, 44, "Wrong leading value")
        XCTAssertEqual(edgetInsets.bottom, 13, "Wrong bottom value")
        XCTAssertEqual(edgetInsets.trailing, 44, "Wrong trailing value")
    }
}
