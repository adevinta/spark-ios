//
//  SwitchUITests.swift
//  SparkDemoUITests
//
//  Created by xavier.daleau on 06/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SwitchUITests: XCTestCase {

    private let app: XCUIApplication = XCUIApplication()

    func test_existence() throws {
        self.getToSwitchScreen()
        let switchButton = try XCTUnwrap(self.getSwitchButton())
        XCTAssertTrue(switchButton.exists)
    }

    func test_default_accessibility_properties() throws {
        // GIVEN
        self.getToSwitchScreen()
        let switchButton = try XCTUnwrap(self.getSwitchButton())

        // THEN
        XCTAssertEqual(switchButton.label, "Text", "wrong accessibility label")
        XCTAssertTrue(switchButton.isEnabled, "switch should be enabled")
        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button, .selected]
        let unexpectedTraits: [UIAccessibilityTraits] = [.notEnabled]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
        for (index, unexpectedTrait) in unexpectedTraits.enumerated() {
            XCTAssertFalse(traits.contains(unexpectedTrait), "Unexpected trait with index \(index) is present")
        }
    }

    func test_default_after_tap_accessibility_properties() throws {
        // GIVEN
        self.getToSwitchScreen()
        let switchButton = try XCTUnwrap(self.getSwitchButton())
        // WHEN
        switchButton.tap()
        // THEN
        XCTAssertEqual(switchButton.label, "Text", "wrong accessibility label")
        XCTAssertTrue(switchButton.isEnabled, "switch should be enabled")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button]
        let unexpectedTraits: [UIAccessibilityTraits] = [.selected, .notEnabled]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
        for (index, unexpectedTrait) in unexpectedTraits.enumerated() {
            XCTAssertFalse(traits.contains(unexpectedTrait), "Unexpected trait with index \(index) is present")
        }
    }

    func test_disabled_state_accessibility_properties() throws {
        self.getToSwitchScreen()
        let switchButton = try XCTUnwrap(self.getSwitchButton())

        /// Tap isEnabled configuration switch
        let isEnabledConfigurationToggle = self.app.switches["is enabledItemToggle"].firstMatch
        isEnabledConfigurationToggle.tap()

        XCTAssertEqual(switchButton.label, "Text", "wrong accessibility label")
        XCTAssertFalse(switchButton.isEnabled, "Switch should be disabled")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button, .selected, .notEnabled]
        let unexpectedTraits: [UIAccessibilityTraits] = []
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
        for (index, unexpectedTrait) in unexpectedTraits.enumerated() {
            XCTAssertFalse(traits.contains(unexpectedTrait), "Unexpected trait with index \(index) is present")
        }
    }

    func test_disabled_state_after_tap_accessibility_properties() throws {
        self.getToSwitchScreen()
        // GIVEN
        let switchButton = try XCTUnwrap(self.getSwitchButton())

        // WHEN
        switchButton.tap()

        /// Tap isEnabled configuration switch
        let isEnabledConfigurationToggle = self.app.switches["is enabledItemToggle"].firstMatch
        isEnabledConfigurationToggle.tap()

        XCTAssertEqual(switchButton.label, "Text", "wrong accessibility label")
        XCTAssertFalse(switchButton.isEnabled, "Switch should be disabled")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button, .notEnabled]
        let unexpectedTraits: [UIAccessibilityTraits] = [.selected]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
        for (index, unexpectedTrait) in unexpectedTraits.enumerated() {
            XCTAssertFalse(traits.contains(unexpectedTrait), "Unexpected trait with index \(index) is present")
        }
    }

    private func getSwitchButton() -> XCUIElement? {
         return self.app.buttons["switch-tag"].firstMatch
    }

    private func getToSwitchScreen() {
        self.app.launch()
        self.goToComponent(named: "Switch Button",
                           app: self.app)
    }
}
