//
//  CheckboxColorsUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class CheckboxColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!
    var checkboxTheming: CheckboxTheming!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.theme = ThemeGeneratedMock.mock
        self.checkboxTheming = CheckboxTheming(theme: theme)
    }

    // MARK: - Tests
    func test_enabled_colors() throws {
        // Given
        let sut = sut()

        // When
        let colors = sut.execute(from: checkboxTheming, state: .enabled)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxTintColor].map(\.color),
            [self.theme.colors.primary.primaryContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.primary.primary
            ].map(\.color))
    }

    func test_disabled_colors() throws {
        // Given
        let sut = sut()

        // When
        let colors = sut.execute(from: checkboxTheming, state: .disabled)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxTintColor].map(\.color),
            [self.theme.colors.primary.primaryContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.primary.primary
            ].map(\.color))
    }

    func test_success_colors() throws {
        // Given
        let sut = sut()

        // When
        let colors = sut.execute(from: checkboxTheming, state: .success(message: "message"))

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxTintColor].map(\.color),
            [self.theme.colors.feedback.successContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.success
            ].map(\.color))
    }

    func test_warning_colors() throws {
        // Given
        let sut = sut()

        // When
        let colors = sut.execute(from: checkboxTheming, state: .warning(message: "message"))

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxTintColor].map(\.color),
            [self.theme.colors.feedback.alertContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.alert
            ].map(\.color))
    }

    func test_error_colors() throws {
        // Given
        let sut = sut()

        // When
        let colors = sut.execute(from: checkboxTheming, state: .error(message: "message"))

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxTintColor].map(\.color),
            [self.theme.colors.feedback.errorContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.error
            ].map(\.color))
    }

    // MARK: - Helper Functions
    func sut() ->  CheckboxColorsUseCase {
        return CheckboxColorsUseCase.init(stateColorsUseCase: CheckboxStateColorsUseCase())
    }
}

// MARK: - Helper Extensions
private extension Color {
    static let primary = Color(hue: 235/360, saturation: 1, brightness: 1)
    static let primaryContainer = Color(hue: 235/360, saturation: 0.8, brightness: 1)
    static let onPrimary = Color(hue: 123/360, saturation: 1, brightness: 1)
    static let onSurface = Color(hue: 200/360, saturation: 1, brightness: 0.5)
    static let alert = Color(hue: 50/360, saturation: 1, brightness: 1)
    static let alertContainer = Color(hue: 50/360, saturation: 0.5, brightness: 0.5)
    static let error = Color(hue: 1/360, saturation: 1, brightness: 1)
    static let errorContainer = Color(hue: 1/360, saturation: 0.5, brightness: 0.5)
    static let success = Color(hue: 100/360, saturation: 1, brightness: 1)
    static let successContainer = Color(hue: 100/360, saturation: 0.5, brightness: 0.5)
}

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()
        theme.colors = .mock
        return theme
    }
}

private extension Colors where Self == ColorsGeneratedMock {
    static var mock: Self {
        let colors = ColorsGeneratedMock()
        let base = ColorsBaseGeneratedMock()

        base.onSurface = .mock(.onSurface)

        let feedback = ColorsFeedbackGeneratedMock()
        feedback.alert = .mock(.alert)
        feedback.alertContainer = .mock(.alertContainer)

        feedback.error = .mock(.error)
        feedback.errorContainer = .mock(.errorContainer)
        feedback.success = .mock(.success)
        feedback.successContainer = .mock(.successContainer)

        let primary = ColorsPrimaryGeneratedMock()
        primary.primaryContainer = .mock(.primaryContainer)
        primary.primary = .mock(.primary)
        primary.onPrimary = .mock(.onPrimary)

        colors.base = base
        colors.primary = primary
        colors.feedback = feedback

        return colors
    }
}

private extension ColorToken where Self == ColorTokenGeneratedMock {
    static func mock(_ color: Color) -> Self {
        let mock = ColorTokenGeneratedMock()
        mock.color = color
        return mock
    }
}
