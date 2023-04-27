//
//  RadioButtonViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtonViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var bindingValue: Int = 0
    var subscription: Cancellable?

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mock
    }

    // MARK: - Tests
    func test_opacity() throws {
        // Given
        let opacities = sutValues(for: \.opacity)

        // Then
        XCTAssertEqual(opacities, [0.40, 1.0, 1.0, 1.0, 1.0])
    }

    func test_is_disabled() {
        // Given
        let disabledStates = sutValues(for: \.isDisabled)

        // Then
        XCTAssertEqual(disabledStates, [true, false, false, false, false])
    }

    func test_spacings() {
        // Given
        let spacings = sutValues(for: \.spacing)

        // Then
        XCTAssertEqual(spacings, Array(repeating: 5.0, count: 5))
    }

    func test_fonts() {
        // Given
        let fonts = sutValues(for: \.font)

        // Then
        XCTAssertEqual(fonts, Array(repeating: Font.body, count: 5))
    }

    func test_supplementaryFonts() {
        // Given
        let fonts = sutValues(for: \.suplemetaryFont)

        // Then
        XCTAssertEqual(fonts, Array(repeating: Font.caption, count: 5))
    }

    func test_surfaceColors() {
        // Given
        let surfaceColors = sutValues(for: \.surfaceColor)

        // Then
        XCTAssertEqual(surfaceColors, Array(repeating: Color.red, count: 5))
    }

    func test_supplementaryTexts() {
        // Given
        let supplementaryTexts = sutValues(for: \.suplementaryText)

        // Then
        XCTAssertEqual(supplementaryTexts, [nil, nil, "Success", "Warning", "Error"])
    }

    func test_colors_reset_when_selected_value_set() {
        // Given
        let sut = sut(state: .enabled)
        let expectation = XCTestExpectation(description: "Colors published when selection changes.")
        expectation.expectedFulfillmentCount = 2

        self.subscription = sut.$colors.sink(receiveValue: { _ in
            expectation.fulfill()
        })
        // When
        sut.setSelected()

        // Then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(self.bindingValue, 1)
    }

    // MARK: - Private Helper Functions

    private func sutValues<T>(for keyPath: KeyPath<RadioButtonViewModel<Int>, T>) -> [T] {
        // Given
        let statesToTest: [SparkSelectButtonState] = [
            .disabled,
            .enabled,
            .success(message: "Success"),
            .warning(message: "Warning"),
            .error(message: "Error")
        ]

        return statesToTest
            .map(sut(state:))
            .map{ $0[keyPath: keyPath] }

    }

    private func sut(state: SparkSelectButtonState) -> RadioButtonViewModel<Int> {
        let seletedId = Binding(
            get: { self.bindingValue },
            set: { self.bindingValue = $0 }
        )

        return RadioButtonViewModel(theme: self.theme,
                                    id: 1,
                                    label: "Test",
                                    selectedID: seletedId,
                                    state: state)

    }
}

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        let base = ColorsBaseGeneratedMock()
        base.outline = ColorTokenGeneratedMock()
        base.surface = ColorTokenGeneratedMock()

        let onSurface = ColorTokenGeneratedMock()
        onSurface.color = Color.red
        base.onSurface = onSurface

        let primary = ColorsPrimaryGeneratedMock()
        primary.primaryContainer = ColorTokenGeneratedMock()
        primary.primary = ColorTokenGeneratedMock()

        let feedback = ColorsFeedbackGeneratedMock()
        feedback.success = ColorTokenGeneratedMock()
        feedback.successContainer = ColorTokenGeneratedMock()

        feedback.alert = ColorTokenGeneratedMock()
        feedback.alertContainer = ColorTokenGeneratedMock()
        feedback.onAlertContainer = ColorTokenGeneratedMock()

        feedback.error = ColorTokenGeneratedMock()
        feedback.errorContainer = ColorTokenGeneratedMock()

        colors.base = base
        colors.primary = primary
        colors.feedback = feedback

        let layout = LayoutGeneratedMock()
        let spacing = LayoutSpacingGeneratedMock()
        spacing.medium = 5
        layout.spacing = spacing

        let typography = TypographyGeneratedMock()
        let body1 = TypographyFontTokenGeneratedMock()
        body1.font = .body

        let caption = TypographyFontTokenGeneratedMock()
        caption.font = .caption

        typography.body1 = body1
        typography.caption = caption

        theme.colors = colors
        theme.layout = layout
        theme.typography = typography

        let dims = DimsGeneratedMock()
        dims.dim3 = 0.40

        theme.dims = dims

        return theme
    }
}
