//
//  ControlTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ControlTests: XCTestCase {

    // MARK: - Tests

    func test_default_values() {
        // GIVEN / WHEN
        let control = Control()

        // THEN
        XCTAssertFalse(control.isDisabled, "Wrong isDisabled value")
        XCTAssertFalse(control.isSelected, "Wrong isSelected value")
        XCTAssertFalse(control.isPressed, "Wrong isPressed value")
    }
}
