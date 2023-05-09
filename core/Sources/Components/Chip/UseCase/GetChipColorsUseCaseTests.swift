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

        self.intentColorsUseCase = GetChipIntentColorsUseCasableGeneratedMock()
        self.sut = GetChipColorsUseCase(intentColorsUseCase: intentColorsUseCase)
        self.theme = ThemeGeneratedMock()
    }

    // MARK: - Tests
    func test_all_standard_filled_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentColorReturnValue = ChipIntentColors(
            primary: .red,
            secondary: .green,
            tintedPrimary: .purple,
            tintedSecondary: .blue)

        let expected = ChipColors(
            default: ChipStateColors(
                background: .red,
                border: .red,
                foreground: .green),
            pressed: ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .red))

        // When
        for intentColor in [ChipIntentColor.primary, .secondary, .alert, .danger, .info, .neutral, .success] {

            let given = sut.execute(theme: theme, variant: .filled, intent: intentColor)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_all_standard_bordered_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentColorReturnValue = ChipIntentColors(
            primary: .red,
            secondary: .green,
            tintedPrimary: .purple,
            tintedSecondary: .blue)

        let expected = ChipColors(
            default: ChipStateColors(
                background: .clear,
                border: .red,
                foreground: .red),
            pressed: ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .red))

        for variant in [ChipVariant.outlined, .dashed] {
            // When
            for intentColor in [ChipIntentColor.primary, .secondary, .alert, .danger, .info, .neutral, .success] {

                let given = sut.execute(theme: theme, variant: variant, intent: intentColor)

                // Then
                XCTAssertEqual(given, expected)
            }
        }
    }

    func test_all_standard_tinted_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentColorReturnValue = ChipIntentColors(
            primary: .red,
            secondary: .green,
            tintedPrimary: .purple,
            tintedSecondary: .blue)

        let expected = ChipColors(
            default: ChipStateColors(
                background: .purple,
                border: .purple,
                foreground: .blue),
            pressed: ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .purple))

        // When
        for intentColor in [ChipIntentColor.primary, .secondary, .alert, .danger, .info, .neutral, .success] {

            let given = sut.execute(theme: theme, variant: .tinted, intent: intentColor)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_surface_bordered_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentColorReturnValue = ChipIntentColors(
            primary: .red,
            secondary: .green,
            tintedPrimary: .purple,
            tintedSecondary: .blue)

        let expected = ChipColors(
            default: ChipStateColors(
                background: .clear,
                border: .green,
                foreground: .green),
            pressed: ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .red))

        // When
        for variant in [ChipVariant.outlined, .dashed] {

            let given = sut.execute(theme: theme, variant: variant, intent: .surface)

            // Then
            XCTAssertEqual(given, expected)
        }
    }

    func test_surface_filled_colors() {
        // Given
        self.theme.border = BorderGeneratedMock()
        self.theme.colors = ColorsGeneratedMock()
        self.intentColorsUseCase.executeWithColorsAndIntentColorReturnValue = ChipIntentColors(
            primary: .red,
            secondary: .green,
            tintedPrimary: .purple,
            tintedSecondary: .blue)

        let expected = ChipColors(
            default: ChipStateColors(
                background: .red,
                border: .red,
                foreground: .green),
            pressed: ChipStateColors(
                background: .blue,
                border: .blue,
                foreground: .red)
        )

        // When
        let given = sut.execute(theme: theme, variant: .filled, intent: .surface)

        // Then
        XCTAssertEqual(given, expected)
    }
}

// MARK: Private helpers
extension ChipColors: Equatable {
    public static func == (lhs: ChipColors, rhs: ChipColors) -> Bool {
        lhs.default == rhs.default && lhs.pressed == rhs.pressed
    }
}

extension ChipStateColors: Equatable {
    public static func == (lhs: ChipStateColors, rhs: ChipStateColors) -> Bool {
        return equal(lhs.border, rhs.border) &&
        equal(lhs.background, rhs.background) &&
        equal(lhs.foreground, rhs.foreground)
    }

    static func equal(_ lhs: ColorToken, _ rhs: ColorToken) -> Bool {
        return lhs.color == rhs.color && lhs.uiColor == rhs.uiColor
    }
}

private extension ChipIntentColors {
    init(primary: UIColor,
     secondary: UIColor,
     tintedPrimary: UIColor,
     tintedSecondary: UIColor) {
        self.init(primary: ColorTokenGeneratedMock(uiColor: primary),
                  secondary: ColorTokenGeneratedMock(uiColor: secondary),
                  tintedPrimary: ColorTokenGeneratedMock(uiColor: tintedPrimary),
                  tintedSecondary: ColorTokenGeneratedMock(uiColor:tintedSecondary))
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
