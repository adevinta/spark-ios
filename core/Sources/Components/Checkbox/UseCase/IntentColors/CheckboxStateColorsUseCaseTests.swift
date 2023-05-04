//
//  CheckboxStateColorsUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 04.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//


import XCTest
import SwiftUI
@testable import SparkCore

final class CheckboxStateColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.theme = ThemeGeneratedMock.mock
    }

    // MARK: - Tests
    func test_enabled_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .enabled, on: theme.colors)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxColor].map(\.color),
            [self.theme.colors.primary.primaryContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.primary.primary
            ].map(\.color))
    }

    func test_disabled_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .disabled, on: theme.colors)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxColor].map(\.color),
            [self.theme.colors.primary.primaryContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.primary.primary
            ].map(\.color))
    }

    func test_success_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .success(message: "message"), on: theme.colors)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxColor].map(\.color),
            [self.theme.colors.feedback.successContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.success
            ].map(\.color))
    }

    func test_warning_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .warning(message: "message"), on: theme.colors)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxColor].map(\.color),
            [self.theme.colors.feedback.alertContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.alert
            ].map(\.color))
    }

    func test_error_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .error(message: "message"), on: theme.colors)

        // Then
        XCTAssertEqual(
            [colors.pressedBorderColor,
             colors.checkboxIconColor,
             colors.textColor,
             colors.checkboxColor].map(\.color),
            [self.theme.colors.feedback.errorContainer,
             self.theme.colors.primary.onPrimary,
             self.theme.colors.base.onSurface,
             self.theme.colors.feedback.error
            ].map(\.color))
    }

    // MARK: - Helper Functions
    func sut() ->  CheckboxStateColorsUseCase {
        return CheckboxStateColorsUseCase()
    }
}

// MARK: - Helper Extensions
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
        colors.base = ColorsBaseGeneratedMock.mocked()
        colors.primary = ColorsPrimaryGeneratedMock.mocked()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()

        return colors
    }
}
