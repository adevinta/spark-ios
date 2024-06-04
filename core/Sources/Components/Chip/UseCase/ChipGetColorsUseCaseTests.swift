//
//  ChipGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 08.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest
@testable import SparkCore
import SparkThemingTesting

final class ChipGetColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    private var sut: ChipGetColorsUseCase!
    private var outlinedIntentColorsUseCase: ChipGetIntentColorsUseCasableGeneratedMock!
    private var tintedIntentColorsUseCase: ChipGetIntentColorsUseCasableGeneratedMock!
    private var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.outlinedIntentColorsUseCase = .init()
        self.tintedIntentColorsUseCase = .init()
        self.sut = .init(
            outlinedIntentColorsUseCase: self.outlinedIntentColorsUseCase,
            tintedIntentColorsUseCase: self.tintedIntentColorsUseCase)
        self.theme = .init()

        let dims = DimsGeneratedMock()
        dims.dim3 = 0.33
        self.theme.dims = dims
    }

// MARK: - Tests

    func test_outlined_variant_uses_correct_use_case() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.outlinedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.background,
            border: chipIntentColors.border,
            foreground: chipIntentColors.text,
            opacity: 1.0)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .outlined, intent: .basic, state: .default)

        XCTAssertEqual(colors, expectedColors)
    }

    func test_tinted_variant_uses_correct_use_case() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.tintedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.background,
            border: chipIntentColors.border,
            foreground: chipIntentColors.text,
            opacity: 1.0)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .tinted, intent: .basic, state: .default)

        XCTAssertEqual(colors, expectedColors)
    }

    func test_pressed_has_correct_background() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.tintedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.pressedBackground,
            border: chipIntentColors.border,
            foreground: chipIntentColors.text,
            opacity: 1.0)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .tinted, intent: .basic, state: .pressed)

        XCTAssertEqual(colors, expectedColors)
    }

    func test_selected_has_correct_backgorund_and_text() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.tintedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.selectedBackground,
            border: chipIntentColors.border,
            foreground: chipIntentColors.selectedText,
            opacity: 1.0)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .tinted, intent: .basic, state: .selected)

        XCTAssertEqual(colors, expectedColors)
    }

    func test_disabled_has_correct_opacity() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.tintedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.background,
            border: chipIntentColors.border,
            foreground: chipIntentColors.text,
            opacity: self.theme.dims.dim3)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .tinted, intent: .basic, state: .disabled)

        XCTAssertEqual(colors, expectedColors)
    }

    func test_selected_and_disabled_has_correct_background() {
        // Given
        let chipIntentColors = ChipIntentColors.mocked()

        self.tintedIntentColorsUseCase.executeWithThemeAndIntentReturnValue = chipIntentColors

        let expectedColors = ChipStateColors(
            background: chipIntentColors.selectedBackground,
            border: chipIntentColors.border,
            foreground: chipIntentColors.selectedText,
            opacity: self.theme.dims.dim3)

        // When
        let colors = self.sut.execute(theme: self.theme, variant: .tinted, intent: .basic, state: .selectedDisabled)

        XCTAssertEqual(colors, expectedColors)
    }
}

private extension ChipIntentColors {
    static func mocked() -> ChipIntentColors {
        return .init(
            border: ColorTokenGeneratedMock.random(),
            text: ColorTokenGeneratedMock.random(),
            selectedText: ColorTokenGeneratedMock.random(),
            background: ColorTokenGeneratedMock.random(),
            pressedBackground: ColorTokenGeneratedMock.random(),
            selectedBackground: ColorTokenGeneratedMock.random())
    }
}

private extension ChipState {
    static let pressed = ChipState(isEnabled: true, isPressed: true, isSelected: false)
    static let disabled = ChipState(isEnabled: false, isPressed: false, isSelected: false)
    static let selected = ChipState(isEnabled: true, isPressed: false, isSelected: true)
    static let selectedDisabled = ChipState(isEnabled: false, isPressed: false, isSelected: true)
}
