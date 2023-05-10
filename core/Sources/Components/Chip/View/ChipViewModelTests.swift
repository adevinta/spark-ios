//
//  ChipViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 10.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class ChipViewModelTests: TestCase {

    var sut: ChipViewModel!
    var useCase: GetChipColorsUseCasableGeneratedMock!
    var theme: ThemeGeneratedMock!
    var subscriptions: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.useCase = GetChipColorsUseCasableGeneratedMock()
        self.theme = ThemeGeneratedMock.mocked()
        self.subscriptions = .init()

        let colorToken = ColorTokenGeneratedMock()

        self.useCase.executeWithThemeAndVariantAndIntentReturnValue = ChipColors(
            default: ChipStateColors(background: colorToken, border: colorToken, foreground: colorToken),
            pressed: ChipStateColors(background: colorToken, border: colorToken, foreground: colorToken))

        self.sut = ChipViewModel(theme: theme,
                                 variant: .filled,
                                 intentColor: .primary,
                                 useCase: useCase)
    }

    func test_variant_chang_triggers_publishers() throws {
        // Given
        let updateExpectation = expectation(description: "Colors and border status updated")
        updateExpectation.expectedFulfillmentCount = 2

        Publishers.Zip(self.sut.$colors, self.sut.$isBorderDashed).sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        self.sut.variant = .dashed

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_theme_change_triggers_publishers() throws {
        // Given
        let updateExpectation = expectation(description: "Colors and other attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip4(self.sut.$padding,
                        self.sut.$spacing,
                        self.sut.$borderRadius,
                        self.sut.$font)

        Publishers.Zip(self.sut.$colors, publishers)
            .sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        self.sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_intent_change_triggers_colors() throws {
        // Given
        let updateExpectation = expectation(description: "Colors updated")
        updateExpectation.expectedFulfillmentCount = 2

        self.sut.$colors.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        self.sut.intentColor = .alert

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }
}

//@Published var spacing: CGFloat
//@Published var padding: CGFloat
//@Published var borderRadius: CGFloat
//@Published var font: TypographyFontToken
//@Published var colors: ChipColors
//@Published var isBorderDashed: Bool

private extension ThemeGeneratedMock {
    static func mocked() -> ThemeGeneratedMock {
        let theme = ThemeGeneratedMock()

        theme.colors =  ColorsGeneratedMock.mocked()
        theme.layout = LayoutGeneratedMock.mocked()
        theme.typography = TypographyGeneratedMock.mocked()

        theme.dims = DimsGeneratedMock.mocked()
        theme.border = BorderGeneratedMock.mocked()

        return theme
    }
}
