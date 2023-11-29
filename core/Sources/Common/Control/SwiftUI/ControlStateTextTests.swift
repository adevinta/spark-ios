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

        // WHEN
        controlStateText.setText(
            givenText,
            for: .normal,
            on: .init()
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

        // WHEN
        controlStateText.setAttributedText(
            givenAttributedText,
            for: .normal,
            on: .init()
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
    }

    func test_updateContent() {
        // GIVEN
        let givenDisabledText = "My Disabled Text"

        let control = Control(isDisabled: true)

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
