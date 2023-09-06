//
//  GetChipColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 08.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import SwiftUI
import XCTest

@testable import SparkCore

final class GetChipColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    private var sut: GetChipColorsUseCase!
    private var intentColorsUseCase: GetChipIntentColorsUseCasableGeneratedMock!
    private var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()

        self.intentColorsUseCase = .init()
        self.sut = .init(intentColorsUseCase: intentColorsUseCase)
        self.theme = .init()
    }

    // MARK: - Tests
    func test_all_standard_filled_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .red,
                border: .red,
                foreground: .green)

        // When
        for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {
            let given = sut.execute(theme: theme, variant: .filled, intent: intentColor, state: .default)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_all_standard_filled_pressed_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .red)

        // When
        for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {
            let given = sut.execute(theme: theme, variant: .filled, intent: intentColor, state: .pressed)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_all_standard_bordered_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .clear,
                border: .red,
                foreground: .red)

        for variant in [ChipVariant.outlined, .dashed] {
            // When
            for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {

                let given = sut.execute(theme: theme, variant: variant, intent: intentColor, state: .default)

                // Then
                XCTAssertEqual(given, expected)
            }
        }
    }

    func test_all_standard_bordered_pressed_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .red)

        for variant in [ChipVariant.outlined, .dashed] {
            // When
            for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {

                let given = sut.execute(theme: theme, variant: variant, intent: intentColor, state: .pressed)

                // Then
                XCTAssertEqual(given, expected)
            }
        }
    }

    func test_all_standard_tinted_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .blue)

        // When
        for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {

            let given = sut.execute(theme: theme, variant: .tinted, intent: intentColor, state: .default)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_all_standard_tinted_pressed_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .purple)

        // When
        for intentColor in [ChipIntent.main, .support, .alert, .danger, .info, .neutral, .success, .accent, .basic] {

            let given = sut.execute(theme: theme, variant: .tinted, intent: intentColor, state: .pressed)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_surface_bordered_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .clear,
                border: .green,
                foreground: .green)
        // When
        for variant in [ChipVariant.outlined, .dashed] {

            let given = sut.execute(theme: theme, variant: variant, intent: .surface, state: .default)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_surface_bordered_pressed_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .red)

        // When
        for variant in [ChipVariant.outlined, .dashed] {

            let given = sut.execute(theme: theme, variant: variant, intent: .surface, state: .pressed)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_surface_filled_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .red,
                border: .red,
                foreground: .green)

        // When
        let given = sut.execute(theme: theme, variant: .filled, intent: .surface, state: .default)

        // Then
        XCTAssertEqual(given, expected)
    }

    func test_surface_filled_pressed_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentReturnValue = ChipIntentColors(
            principal: .red,
            subordinate: .green,
            tintedPrincipal: .purple,
            tintedSubordinate: .blue)

        let expected = ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .red)

        // When
        let given = sut.execute(theme: theme, variant: .filled, intent: .surface, state: .pressed)

        // Then
        XCTAssertEqual(given, expected)
    }
}

private extension ChipIntentColors {
    init(principal: UIColor,
     subordinate: UIColor,
     tintedPrincipal: UIColor,
     tintedSubordinate: UIColor) {
        self.init(principal: ColorTokenGeneratedMock(uiColor: principal),
                  subordinate: ColorTokenGeneratedMock(uiColor: subordinate),
                  tintedPrincipal: ColorTokenGeneratedMock(uiColor: tintedPrincipal),
                  tintedSubordinate: ColorTokenGeneratedMock(uiColor:tintedSubordinate))
    }
}

private extension ColorTokenGeneratedMock {
    convenience init(uiColor: UIColor) {
        self.init()
        self.uiColor = uiColor
    }
}

private extension ChipStateColors {
    init(background: UIColor,
         border: UIColor,
         foreground: UIColor) {
        self.init(background: ColorTokenGeneratedMock(uiColor:background),
                  border: ColorTokenGeneratedMock(uiColor:border),
                  foreground: ColorTokenGeneratedMock(uiColor:foreground))
    }
}

private extension ChipState {
    static let pressed = ChipState(isEnabled: true, isPressed: true)
    static let disabled = ChipState(isEnabled: false, isPressed: false)
}
