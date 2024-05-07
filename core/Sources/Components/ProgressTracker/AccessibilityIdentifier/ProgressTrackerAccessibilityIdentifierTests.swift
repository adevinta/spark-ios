//
//  ProgressTrackerAccessibilityIdentifierTests.swift
//  SparkCoreUnitTests
//
//  Created by Michael Zimmermann on 09.02.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import SparkCore
import XCTest

final class ProgressTrackerAccessibilityIdentifierTests: XCTestCase {

    func test_indicator_identifier() {
        XCTAssertEqual(ProgressTrackerAccessibilityIdentifier.indicator(forIndex: 99), "spark-progress-tracker-indicator-99")
    }

    func test_label_identifier() {
        XCTAssertEqual(ProgressTrackerAccessibilityIdentifier.label(forIndex: 99), "spark-progress-tracker-label-99")
    }
}
