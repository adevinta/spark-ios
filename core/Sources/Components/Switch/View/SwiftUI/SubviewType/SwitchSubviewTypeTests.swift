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

    func test_allCases_when_isLeftAlignment_is_true_and_showSpace_is_false() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.allCases(
            isLeftAlignment: true,
            showSpace: false
        )

        // THEN
        XCTAssertEqual(
            allCases,
            [.toggle, .text]
        )
    }

    func test_allCases_when_isLeftAlignment_is_true_and_showSpace_is_true() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.allCases(
            isLeftAlignment: true,
            showSpace: true
        )

        // THEN
        XCTAssertEqual(
            allCases,
            [.toggle, .space, .text]
        )
    }

    func test_allCases_when_isLeftAlignment_is_false_and_showSpace_is_false() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.allCases(
            isLeftAlignment: false,
            showSpace: false
        )

        // THEN
        XCTAssertEqual(
            allCases,
            [.text, .toggle]
        )
    }

    func test_allCases_when_isLeftAlignment_is_false_and_showSpace_is_true() {
        // GIVEN / WHEN
        let allCases = SwitchSubviewType.allCases(
            isLeftAlignment: false,
            showSpace: true
        )

        // THEN
        XCTAssertEqual(
            allCases,
            [.text, .space, .toggle]
        )
    }
}
