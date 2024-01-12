//
//  ButtonManagerTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 28/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class ButtonManagerTests: XCTestCase {

    // MARK: - Setter Tests

    func test_setTitle() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let text = "My Text"

        manager.setIsSelected(true)

        // WHEN
        manager.setTitle(
            text,
            for: .selected
        )

        // THEN
        XCTAssertEqual(
            manager.controlStateText.text,
            text,
            "Wrong text"
        )
    }

    func test_setAttributedTitle() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let attributedText = AttributedString("My AT Text")

        manager.setIsDisabled(true)

        // WHEN
        manager.setAttributedTitle(
            attributedText,
            for: .disabled
        )

        // THEN
        XCTAssertEqual(
            manager.controlStateText.attributedText,
            attributedText,
            "Wrong attributedText"
        )
    }

    func test_setIsPressed() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isPressedMock = true
        let isPressedText = "My Text"

        let expectedControl = ControlStatus(
            isHighlighted: isPressedMock
        )

        stub.addTextOnControlState(
            isPressedText,
            for: .highlighted
        )

        // WHEN
        manager.setIsPressed(isPressedMock)

        // THEN
        XCTAssertEqual(
            manager.controlStatus,
            .init(isHighlighted: isPressedMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateText.text,
            isPressedText,
            "Wrong text"
        )
    }

    func test_setIsDisabled() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isDisabledMock = true
        let isDisabledText = "My Text"

        let expectedControl = ControlStatus(
            isEnabled: !isDisabledMock
        )

        stub.addTextOnControlState(
            isDisabledText,
            for: .disabled
        )

        // WHEN
        manager.setIsDisabled(isDisabledMock)

        // THEN
        XCTAssertEqual(
            manager.controlStatus,
            .init(isEnabled: !isDisabledMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateText.text,
            isDisabledText,
            "Wrong text"
        )
    }

    func test_setIsSelected() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isSelectedMock = true
        let isSelectedText = "My Text"

        let expectedControl = ControlStatus(
            isSelected: isSelectedMock
        )

        stub.addTextOnControlState(
            isSelectedText,
            for: .selected
        )

        // WHEN
        manager.setIsSelected(isSelectedMock)

        // THEN
        XCTAssertEqual(
            manager.controlStatus,
            .init(isSelected: isSelectedMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateText.text,
            isSelectedText,
            "Wrong text"
        )
    }
}

// MARK: - Stub

private struct Stub {

    // MARK: - Properties

    let controlStateText = ControlStateText()
    var manager: ButtonManager

    // MARK: - Initialization

    init() {
        let viewModel = ButtonViewModel(
            for: .swiftUI,
            theme: ThemeGeneratedMock.mocked(),
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded,
            alignment: .leadingImage
        )

        self.manager = ButtonManager(
            viewModel: viewModel,
            controlStateText: self.controlStateText, 
            controlStateImage: .init()
        )
    }

    // MARK: - Methods

    func addTextOnControlState(
        _ text: String,
        for controlState: ControlState
    ) {
        self.controlStateText.setText(
            text,
            for: controlState,
            on: self.manager.controlStatus
        )
    }
}
