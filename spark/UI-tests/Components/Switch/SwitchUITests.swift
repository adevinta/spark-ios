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
        XCTAssertTrue(switchButton.isSelected, "switch should be selected")
        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
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
        XCTAssertFalse(switchButton.isSelected, "switch should not be selected")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
    }

    func test_disabled_state_accessibility_properties() throws {
        self.getToSwitchScreen()
        let switchButton = try XCTUnwrap(self.getSwitchButton())

        /// Tap isEnabled configuration switch
        let isEnabledConfigurationToggle = self.app.switches["is enabledItemToggle"].firstMatch
        isEnabledConfigurationToggle.tap()

        XCTAssertEqual(switchButton.label, "Text", "wrong accessibility label")
        XCTAssertFalse(switchButton.isEnabled, "Switch should be disabled")
        XCTAssertTrue(switchButton.isSelected, "switch should be selected")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button]
        let unexpectedTraits: [UIAccessibilityTraits] = []
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
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
        XCTAssertFalse(switchButton.isSelected, "switch should not be selected")

        let traits = try XCTUnwrap(switchButton.traits)
        let expectedTraits: UIAccessibilityTraits = [.button]
        XCTAssertTrue(traits.contains(expectedTraits), "Expected traits are absent")
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
