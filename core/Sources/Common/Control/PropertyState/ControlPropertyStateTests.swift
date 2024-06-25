//
//  ControlPropertyStateTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ControlPropertyStateTests: XCTestCase {

    // MARK: - Tests

    func test_default_value() {
        // GIVEN / WHEN
        let state = ControlPropertyState<String>(for: .normal)

        // THEN
        XCTAssertNil(
            state.value,
            "Wrong value. Should be nil"
        )
    }
}
