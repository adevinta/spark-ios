//
//  ControlStatusTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ControlStatusTests: XCTestCase {

    // MARK: - Tests

    func test_init() {
        // GIVEN
        let givenIsHighlighted = true
        let givenIsEnabled = true
        let givenIsSelected = true

        // WHEN
        let status = ControlStatus(
            isHighlighted: givenIsHighlighted,
            isEnabled: givenIsEnabled,
            isSelected: givenIsSelected
        )

        // THEN
        XCTAssertEqual(
            status.isHighlighted,
            givenIsHighlighted,
            "Wrong isHighlighted"
        )

        XCTAssertEqual(
            status.isDisabled,
            !givenIsEnabled,
            "Wrong isDisabled"
        )

        XCTAssertEqual(
            status.isSelected,
            givenIsSelected,
            "Wrong isSelected"
        )
    }
}
