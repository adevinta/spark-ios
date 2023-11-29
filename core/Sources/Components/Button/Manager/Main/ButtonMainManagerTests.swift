//
//  ButtonMainManagerTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 28/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonMainManagerTests: XCTestCase {

    // MARK: - Setter Tests

    func test_setImage() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let image = Image("switchOn")

        manager.setIsSelected(true)

        // WHEN
        manager.setImage(
            image,
            for: .selected
        )

        // THEN
        XCTAssertEqual(
            manager.controlStateImage.image,
            image,
            "Wrong image"
        )
    }

    func test_setIsPressed() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isPressedMock = true
        let isPressedImage = Image("switchOn")

        let expectedControl = Control(isPressed: isPressedMock)

        stub.addImageOnControlState(
            isPressedImage,
            for: .highlighted
        )

        // WHEN
        manager.setIsPressed(isPressedMock)

        // THEN
        XCTAssertEqual(
            manager.control,
            .init(isPressed: isPressedMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateImage.image,
            isPressedImage,
            "Wrong image"
        )
    }

    func test_setIsDisabled() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isDisabledMock = true
        let isDisabledImage = Image("switchOn")

        let expectedControl = Control(isDisabled: isDisabledMock)

        stub.addImageOnControlState(
            isDisabledImage,
            for: .disabled
        )

        // WHEN
        manager.setIsDisabled(isDisabledMock)

        // THEN
        XCTAssertEqual(
            manager.control,
            .init(isDisabled: isDisabledMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateImage.image,
            isDisabledImage,
            "Wrong image"
        )
    }

    func test_setIsSelected() {
        // GIVEN
        let stub = Stub()
        let manager = stub.manager

        let isSelectedMock = true
        let isSelectedImage = Image("switchOn")

        let expectedControl = Control(isSelected: isSelectedMock)

        stub.addImageOnControlState(
            isSelectedImage,
            for: .selected
        )

        // WHEN
        manager.setIsSelected(isSelectedMock)

        // THEN
        XCTAssertEqual(
            manager.control,
            .init(isSelected: isSelectedMock),
            "Wrong control value"
        )
        XCTAssertEqual(
            manager.controlStateImage.image,
            isSelectedImage,
            "Wrong image"
        )
    }
}

// MARK: - Stub

private struct Stub {

    // MARK: - Properties

    let controlStateImage = ControlStateImage()
    var manager: ButtonMainManager<ButtonMainViewModel>

    // MARK: - Initialization

    init() {
        let viewModel = ButtonMainViewModel(
            for: .swiftUI,
            type: .button,
            theme: ThemeGeneratedMock.mocked(),
            intent: .accent,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )

        self.manager = ButtonMainManager(
            viewModel: viewModel,
            controlStateImage: self.controlStateImage
        )
    }

    // MARK: - Methods

    func addImageOnControlState(
        _ image: Image,
        for controlState: ControlState
    ) {
        self.controlStateImage.setImage(
            image,
            for: controlState,
            on: self.manager.control
        )
    }
}
