//
//  RadioButtonGetAttributesUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by michael.zimmermann on 26.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
@_spi(SI_SPI) import SparkCommonTesting
import SparkThemingTesting
import XCTest

final class RadioButtonGetAttributesUseCaseTests: TestCase {

    var sut: RadioButtonGetAttributesUseCase!
    var colorsUseCase: RadioButtonGetColorsUseCaseableGeneratedMock!
    var theme: ThemeGeneratedMock!
    var colors: RadioButtonColors!

    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()

        self.colorsUseCase = RadioButtonGetColorsUseCaseableGeneratedMock()
        self.sut = RadioButtonGetAttributesUseCase(colorsUseCase: self.colorsUseCase)
        self.colors = RadioButtonColors(
            button: ColorTokenGeneratedMock.random(),
            label: ColorTokenGeneratedMock.random(),
            halo: ColorTokenGeneratedMock.random(),
            fill: ColorTokenGeneratedMock.random(),
            surface: ColorTokenGeneratedMock.random()
        )
        self.colorsUseCase.executeWithThemeAndIntentAndIsSelectedReturnValue = self.colors

    }

    func test_attributes_enabled_state_leading_alignment() {
        // Given
        let expectedAttributes = RadioButtonAttributes(
            colors: self.colors,
            opacity: 1,
            spacing: self.theme.layout.spacing.xxxLarge,
            font: self.theme.typography.body1)

        // When
        let givenAttributes = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            state: .isEnabled,
            alignment: .leading
        )

        XCTAssertEqual(givenAttributes, expectedAttributes)
    }

    func test_attributes_enabled_state_trailing_alignment() {
        // Given
        let expectedAttributes = RadioButtonAttributes(
            colors: self.colors,
            opacity: 1,
            spacing: self.theme.layout.spacing.medium,
            font: self.theme.typography.body1)

        // When
        let givenAttributes = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            state: .isEnabled,
            alignment: .trailing
        )

        XCTAssertEqual(givenAttributes, expectedAttributes)
    }

    func test_attributes_disabled_state_trailing_alignment() {
        // Given
        let expectedAttributes = RadioButtonAttributes(
            colors: self.colors,
            opacity: self.theme.dims.dim3,
            spacing: self.theme.layout.spacing.medium,
            font: self.theme.typography.body1)

        // When
        let givenAttributes = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            state: .isDisabled,
            alignment: .trailing
        )

        XCTAssertEqual(givenAttributes, expectedAttributes)
    }
}

private extension RadioButtonStateAttribute {
    static var isEnabled = RadioButtonStateAttribute(isSelected: false, isEnabled: true)
    static var isDisabled = RadioButtonStateAttribute(isSelected: false, isEnabled: false)
}
