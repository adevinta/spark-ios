//
//  SwitchSubviewTypeTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 14/09/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SwitchSubviewTypeTests: XCTestCase {

    // MARK: - Tests

    func test_leftAlignmentCases() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.leftAlignmentCases

        // THEN
        XCTAssertEqual(
            allCases,
            [.toggle, .space, .text]
        )
    }

    func test_rightAlignmentCases() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.rightAlignmentCases

        // THEN
        XCTAssertEqual(
            allCases,
            [.text, .space, .toggle]
        )
    }
}
