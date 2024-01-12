//
//  ControlStateTextTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 24/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI

@testable import SparkCore

final class ControlStateTextTests: XCTestCase {

    // MARK: - Tests

    func test_default_values() {
        // GIVEN / WHEN
        let controlStateText = ControlStateText()

        // THEN
        XCTAssertNil(
            controlStateText.text,
            "Wrong text value"
        )
        XCTAssertNil(
            controlStateText.attributedText,
            "Wrong attributedText value"
        )
    }

    func test_setText() {
        // GIVEN
        let givenText = "My Text"

        let controlStateText = ControlStateText()

        let statesMock = ControlPropertyStates<String>()
        statesMock.setValue(
            givenText,
            for: .normal
        )

        var control = ControlStatus()

        // WHEN
        controlStateText.setText(
            givenText,
            for: .normal,
            on: control
        )

        // THEN
        XCTAssertEqual(
            controlStateText.text,
            statesMock.value(for: .normal),
            "Wrong text value"
        )
        XCTAssertNil(
            controlStateText.attributedText,
            "Wrong attributedText value"
        )

        // WHEN
        
        // Check when a text is nil for an another state,
        // The text text for the normal state should be returned

        control.isHighlighted = true

        controlStateText.setText(
            nil,
            for: .highlighted,
            on: control
        )

        // THEN
        XCTAssertEqual(
            controlStateText.text,
            statesMock.value(for: .normal),
            "Wrong text value when control isPressed"
        )
    }

    func test_setAttributedText() {
        // GIVEN
        let givenAttributedText = AttributedString("My AT Text")

        let controlStateText = ControlStateText()

        let statesMock = ControlPropertyStates<AttributedString>()
        statesMock.setValue(
            givenAttributedText,
            for: .normal
        )

        var control = ControlStatus()

        // WHEN
        controlStateText.setAttributedText(
            givenAttributedText,
            for: .normal,
            on: control
        )

        // THEN
        XCTAssertNil(
            controlStateText.text,
            "Wrong text value"
        )
        XCTAssertEqual(
            controlStateText.attributedText,
            statesMock.value(for: .normal),
            "Wrong attributedText value"
        )

        // WHEN

        // Check when a attributedText is nil for an another state,
        // The attributedText value for the normal state should be returned

        control.isHighlighted = true

        controlStateText.setAttributedText(
            nil,
            for: .highlighted,
            on: control
        )

        // THEN
        XCTAssertEqual(
            controlStateText.attributedText,
            statesMock.value(for: .normal),
            "Wrong attributedText value when control isPressed"
        )
    }

    func test_updateContent() {
        // GIVEN
        let givenDisabledText = "My Disabled Text"

        let control = ControlStatus(isEnabled: false)

        let controlStateText = ControlStateText()

        let statesMock = ControlPropertyStates<String>()

        controlStateText.setText(
            givenDisabledText,
            for: .disabled,
            on: .init()
        )
        statesMock.setValue(
            givenDisabledText,
            for: .disabled
        )

        // WHEN
        controlStateText.updateContent(from: control)

        // THEN
        XCTAssertEqual(
            controlStateText.text,
            statesMock.value(for: .disabled)
        )
    }
}
