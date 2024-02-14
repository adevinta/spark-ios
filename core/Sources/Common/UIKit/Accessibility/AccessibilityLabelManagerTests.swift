//
//  AccessibilityLabelManagerTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 24/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class AccessibilityLabelManagerTests: XCTestCase {

    // MARK: - Tests

    func test_default_value() {
        // GIVEN / WHEN
        let manager = AccessibilityLabelManager()

        // THEN
        XCTAssertNil(manager.value)
    }

    func test_value_after_set_internalValue() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.internalValue = expectedValue

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }

    func test_value_after_set_value_without_set_internaValue() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.value = expectedValue

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }

    func test_value_after_set_internalValue_then_set_value() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.internalValue = "My other value"
        manager.value = expectedValue

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }

    func test_value_after_set_value_then_set_internalValue() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.value = expectedValue
        manager.internalValue = "My other value"

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }

    func test_value_after_set_internalValue_then_set_nil_value() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.internalValue = expectedValue
        manager.value = nil

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }

    func test_value_after_set_nil_value_then_set_internalValue() {
        // GIVEN
        let expectedValue = "My value"

        var manager = AccessibilityLabelManager()

        // WHEN
        manager.value = nil
        manager.internalValue = expectedValue

        // THEN
        XCTAssertEqual(manager.value, expectedValue)
    }
}
