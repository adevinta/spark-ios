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
        let expectedTraits: UIAccessibilityTraits
        let unexpectedTraits: [UIAccessibilityTraits]
        if #available(iOS 17.0, *) {
            expectedTraits = [.toggleButton, .selected]
            unexpectedTraits = [.button, .notEnabled]
        } else {
            expectedTraits = [.button, .selected]
            unexpectedTraits = [.notEnabled]
        }
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
        let expectedTraits: UIAccessibilityTraits
        let unexpectedTraits: [UIAccessibilityTraits]
        if #available(iOS 17.0, *) {
            expectedTraits = [.toggleButton]
            unexpectedTraits = [.button, .selected, .notEnabled]
        } else {
            expectedTraits = [.button]
            unexpectedTraits = [.selected, .notEnabled]
        }
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
        let expectedTraits: UIAccessibilityTraits
        let unexpectedTraits: [UIAccessibilityTraits]
        if #available(iOS 17.0, *) {
            expectedTraits = [.toggleButton, .selected, .notEnabled]
            unexpectedTraits = [.button]
        } else {
            expectedTraits = [.button, .selected, .notEnabled]
            unexpectedTraits = []
        }
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
        let expectedTraits: UIAccessibilityTraits
        let unexpectedTraits: [UIAccessibilityTraits]
        if #available(iOS 17.0, *) {
            expectedTraits = [.toggleButton, .notEnabled]
            unexpectedTraits = [.button, .selected]
        } else {
            expectedTraits = [.button, .notEnabled]
            unexpectedTraits = [.selected]
        }
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
        for (index, unexpectedTrait) in unexpectedTraits.enumerated() {
            XCTAssertFalse(traits.contains(unexpectedTrait), "Unexpected trait with index \(index) is present")
        }
    }


    private func getSwitchButton() -> XCUIElement? {
         return self.app.otherElements["switch-tag"].firstMatch
    }

    private func getToSwitchScreen() {
        self.app.launch()
        self.goToComponent(named: "Switch Button",
                           app: self.app)
    }
}
