//
//  ControlPropertyStatesTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 25/10/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ControlPropertyStatesTests: XCTestCase {
    
    // MARK: - Value for States - Tests
    
    func test_value_for_all_states_when_value_is_set() {
        // GIVEN
        let expectedValue = "Value"
        
        let states = ControlState.allCases
        
        for state in states {
            let states = ControlPropertyStates<String>()
            states.setValue(expectedValue, for: state)
            
            // WHEN
            let value = states.value(for: state)
            
            // THEN
            XCTAssertEqual(
                value,
                expectedValue,
                "Wrong value for the .\(state) state"
            )
        }
    }
    
    func test_value_for_all_states_when_value_is_nil() {
        // GIVEN
        let states = ControlState.allCases
        
        for state in states {
            let states = ControlPropertyStates<String>()
            states.setValue(nil, for: state)
            
            // WHEN
            let value = states.value(for: state)
            
            // THEN
            XCTAssertNil(
                value,
                "The value should be nil for the .\(state) state"
            )
        }
    }
    
    // MARK: - Value for Status - Tests
    
    func test_all_values_when_status_isHighlighted() {
        // GIVEN
        let normalStateValue = "normal"
        let highlightedValue = "highlighted"

        let states = ControlPropertyStates<String>()

        // Set value for normal state (default state)
        states.setValue(normalStateValue, for: .normal)

        // **
        // WHEN
        // Test with .highlighted value and true isHighlighted status.

        var status = ControlStatus(isHighlighted: true)
        states.setValue(highlightedValue, for: .highlighted)
        var value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            highlightedValue,
            "Wrong value WHEN status isHighlighted AND set .highlighted state value"
        )
        // **

        // **
        // WHEN
        // Test without .highlighted value and true isHighlighted status.

        status = ControlStatus(isHighlighted: true)
        states.setValue(nil, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status isHighlighted AND nil .highlighted state value"
        )
        // **

        // **
        // WHEN
        // Test with .highlighted value and false isHighlighted status.

        status = .init(isHighlighted: false)

        states.setValue(highlightedValue, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status !isHighlighted AND set .highlighted state value"
        )
        // **
    }
    
    func test_all_values_when_status_isDisabled() {
        // GIVEN
        let normalStateValue = "normal"
        let disabledValue = "disabled"
        let highlightedValue = "highlighted"

        let states = ControlPropertyStates<String>()

        // Set value for normal state (default state)
        states.setValue(normalStateValue, for: .normal)

        // **
        // WHEN
        // Test with .disabled value and false isEnabled status.

        var status = ControlStatus(isEnabled: false)
        states.setValue(disabledValue, for: .disabled)
        var value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            disabledValue,
            "Wrong value WHEN status isDisabled AND set .disabled state value"
        )
        // **

        // **
        // WHEN
        // Test without .disabled value and false isEnabled status.

        status = ControlStatus(isEnabled: false)
        states.setValue(nil, for: .disabled)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status isDisabled AND nil .disabled state value"
        )
        // **

        // **
        // WHEN
        // Test with .disabled value and false isDisabled status.

        status = .init(isEnabled: true)

        states.setValue(disabledValue, for: .disabled)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status !isDisabled AND set .disabled state value"
        )
        // **

        // **
        // WHEN
        // Test with .disabled value and false isEnabled status.
        // AND with value for .highlighted and isHighlighted status is true

        status = .init(isHighlighted: true, isEnabled: false)

        states.setValue(disabledValue, for: .disabled)
        states.setValue(highlightedValue, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            highlightedValue,
            "Wrong value WHEN status isDisabled and isHighlighted AND set .disabled and .highlighted state value"
        )
        // **

        // **
        // WHEN
        // Test with .disabled value and false isEnabled status.
        // AND without value for .highlighted and isHighlighted status is true

        status = .init(isHighlighted: true, isEnabled: false)

        states.setValue(disabledValue, for: .disabled)
        states.setValue(nil, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            disabledValue,
            "Wrong value WHEN status isDisabled and isHighlighted AND set .disabled and nil .highlighted state value"
        )
        // **
    }

    func test_all_values_when_status_isSelected() {
        // GIVEN
        let normalStateValue = "normal"
        let selectedValue = "selected"
        let disabledValue = "disabled"
        let highlightedValue = "highlighted"

        let states = ControlPropertyStates<String>()

        // Set value for normal state (default state)
        states.setValue(normalStateValue, for: .normal)

        var status = ControlStatus(isSelected: true)

        // **
        // WHEN
        // Test with .selected value and true isSelected status.

        states.setValue(selectedValue, for: .selected)
        var value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            selectedValue,
            "Wrong value WHEN status isSelected AND set .selected state value"
        )
        // **

        // **
        // WHEN
        // Test without .selected value and true isSelected status.

        states.setValue(nil, for: .selected)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status isSelected AND nil .selected state value"
        )
        // **

        // **
        // WHEN
        // Test with .selected value and false isSelected status.

        status = .init(isSelected: false)

        states.setValue(selectedValue, for: .selected)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN status !isSelected AND set .selected state value"
        )
        // **

        // **
        // WHEN
        // Test with .selected value and true isSelected status.
        // AND with value for .highlighted and isHighlighted status is true

        status = .init(isHighlighted: true, isSelected: true)

        states.setValue(selectedValue, for: .selected)
        states.setValue(highlightedValue, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            highlightedValue,
            "Wrong value WHEN status isSelected and isHighlighted AND set .selected and .highlighted state value"
        )
        // **

        // **
        // WHEN
        // Test with .selected value and true isSelected status.
        // AND without value for .highlighted and isHighlighted status is true

        status = .init(isHighlighted: true, isSelected: true)

        states.setValue(selectedValue, for: .selected)
        states.setValue(nil, for: .highlighted)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            selectedValue,
            "Wrong value WHEN status isSelected and isHighlighted AND set .selected and nil .highlighted state value"
        )
        // **

        // **
        // WHEN
        // Test with .selected value and true isSelected status.
        // AND with value for .disabled and isEnabled status is false.

        status = .init(isEnabled: false, isSelected: true)

        states.setValue(selectedValue, for: .selected)
        states.setValue(disabledValue, for: .disabled)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            disabledValue,
            "Wrong value WHEN status isSelected and isDisabled AND set .selected and .disabled state value"
        )
        // **

        // **
        // WHEN
        // Test with .selected value and true isSelected status.
        // AND without value for .disabled and isEnabled status is false.

        status = .init(isEnabled: false, isSelected: true)

        states.setValue(selectedValue, for: .selected)
        states.setValue(nil, for: .disabled)
        value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            selectedValue,
            "Wrong value WHEN status isSelected and isDisabled AND set .selected and nil .disabled state value"
        )
        // **
    }

    func test_all_values_when_status_isNormal() {
        // GIVEN
        let normalStateValue = "normal"

        let states = ControlPropertyStates<String>()

        // **
        // WHEN
        // Test with .normal value and all false properties on status.

        var status = ControlStatus()
        states.setValue(normalStateValue, for: .normal)
        var value = states.value(for: status)

        // THEN
        XCTAssertEqual(
            value,
            normalStateValue,
            "Wrong value WHEN all status properties are false AND set .normal state value"
        )
        // **

        // **
        // WHEN
        // Test without .normal value and all false properties on status.

        status = ControlStatus()
        states.setValue(nil, for: .normal)
        value = states.value(for: status)

        // THEN
        XCTAssertNil(
            value,
            "Wrong value WHEN all status properties are false AND nil .normal state value"
        )
        // **
    }
}
