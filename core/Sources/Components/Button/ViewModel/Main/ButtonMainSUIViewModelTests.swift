//
//  ButtonMainSUIViewModelTests.swift
//  SparkCore
//
//  Created by robin.lemaire on 15/01/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
import SparkThemingTesting
import SwiftUI

final class ButtonMainSUIViewModelTests: XCTestCase {

    // MARK: - Init Tests

    func test_setImage() {
        // GIVEN
        let imageMock = Image("switchOff")

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setImage(imageMock, for: .selected)
        viewModel.setIsSelected(true)

        // THEN
        XCTAssertEqual(
            viewModel.controlStateImage.image,
            imageMock,
            "Wrong image"
        )
    }

    func test_setTitle() {
        // GIVEN
        let titleMock = "Title"

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setTitle(titleMock, for: .selected)
        viewModel.setIsSelected(true)

        // THEN
        XCTAssertEqual(
            viewModel.controlStateText?.text,
            titleMock,
            "Wrong title"
        )
    }

    func test_setAttributedTitle() {
        // GIVEN
        let titleMock = AttributedString("Title")

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setAttributedTitle(titleMock, for: .selected)
        viewModel.setIsSelected(true)

        // THEN
        XCTAssertEqual(
            viewModel.controlStateText?.attributedText,
            titleMock,
            "Wrong attributed title"
        )
    }

    func test_setIsPressed() {
        // GIVEN
        let isHighlightedMock = true

        let isHighlightedImageMock = Image("switchOff")
        let isHighlightedTitleMock = "Title"

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setImage(isHighlightedImageMock, for: .highlighted)
        viewModel.setTitle(isHighlightedTitleMock, for: .highlighted)

        viewModel.setIsPressed(isHighlightedMock)

        // THEN
        XCTAssertEqual(
            viewModel.controlStatus.isHighlighted,
            isHighlightedMock,
            "Wrong controlStatus isHighlighted value on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateImage.image,
            isHighlightedImageMock,
            "Wrong image on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateText?.text,
            isHighlightedTitleMock,
            "Wrong title on test 1"
        )

        // **
        // Reverse the isPressed value
        // **

        // WHEN
        viewModel.setIsPressed(!isHighlightedMock)

        // THEN
        XCTAssertEqual(
            viewModel.controlStatus.isHighlighted,
            !isHighlightedMock,
            "Wrong controlStatus isHighlighted value on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateImage.image,
            "Wrong image on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateText?.text,
            "Wrong title on test 2"
        )
    }

    func test_setIsDisabled() {
        // GIVEN
        let isEnableddMock = false

        let isDisabledImageMock = Image("switchOff")
        let isDisabledTitleMock = "Title"

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setImage(isDisabledImageMock, for: .disabled)
        viewModel.setTitle(isDisabledTitleMock, for: .disabled)

        viewModel.setIsDisabled(!isEnableddMock)

        // THEN
        XCTAssertEqual(
            viewModel.isEnabled,
            isEnableddMock,
            "Wrong isEnabled value on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStatus.isEnabled,
            isEnableddMock,
            "Wrong controlStatus isEnabled value on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateImage.image,
            isDisabledImageMock,
            "Wrong image on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateText?.text,
            isDisabledTitleMock,
            "Wrong title on test 1"
        )

        // **
        // Reverse the isDisabled value
        // **

        // WHEN
        viewModel.setIsDisabled(isEnableddMock)

        // THEN
        XCTAssertEqual(
            viewModel.isEnabled,
            !isEnableddMock,
            "Wrong isEnabled value on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStatus.isEnabled,
            !isEnableddMock,
            "Wrong controlStatus isDisabled value on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateImage.image,
            "Wrong image on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateText?.text,
            "Wrong title on test 2"
        )
    }

    func test_setIsSelected() {
        // GIVEN
        let isSelectedMock = true

        let isSelectedImageMock = Image("switchOff")
        let isSelectedTitleMock = "Title"

        let viewModel = ButtonMainSUIViewModelMock()

        // WHEN
        viewModel.setImage(isSelectedImageMock, for: .selected)
        viewModel.setTitle(isSelectedTitleMock, for: .selected)

        viewModel.setIsSelected(isSelectedMock)

        // THEN
        XCTAssertEqual(
            viewModel.controlStatus.isSelected,
            isSelectedMock,
            "Wrong controlStatus isSelected value on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateImage.image,
            isSelectedImageMock,
            "Wrong image on test 1"
        )
        XCTAssertEqual(
            viewModel.controlStateText?.text,
            isSelectedTitleMock,
            "Wrong title on test 1"
        )

        // **
        // Reverse the isSelected value
        // **

        // WHEN
        viewModel.setIsSelected(!isSelectedMock)

        // THEN
        XCTAssertEqual(
            viewModel.controlStatus.isSelected,
            !isSelectedMock,
            "Wrong controlStatus isSelected value on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateImage.image,
            "Wrong image on test 2"
        )
        XCTAssertNil(
            viewModel.controlStateText?.text,
            "Wrong title on test 2"
        )
    }
}

// MARK: - Mock

final class ButtonMainSUIViewModelMock: ButtonMainViewModel, ButtonMainSUIViewModel {

    // MARK: - Properties

    var controlStatus: ControlStatus = .init()
    var controlStateImage: ControlStateImage = .init()
    var controlStateText: ControlStateText? = .init()

    // MARK: - Initialization

    init() {
        super.init(
            for: .swiftUI,
            type: .button,
            theme: ThemeGeneratedMock.mocked(),
            intent: .main,
            variant: .filled,
            size: .medium,
            shape: .rounded
        )
    }
}
