//
//  ButtonVariantGetContrastUseCaseTests.swift
//  SparkCoreTests
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonVariantGetContrastUseCaseTests: ButtonVariantUseCaseTests {

    // MARK: - Tests
    func test_primary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .primary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.primary.primary,
             self.theme.colors.base.surface,
             self.theme.colors.states.primaryContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_secondary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .secondary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.secondary.secondary,
             self.theme.colors.base.surface,
             self.theme.colors.states.secondaryContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_neutral_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .neutral, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.neutral,
             self.theme.colors.base.surface,
             self.theme.colors.states.neutralContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_alert_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .alert, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.alert,
             self.theme.colors.base.surface,
             self.theme.colors.states.alertContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_success_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .success, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.success,
             self.theme.colors.base.surface,
             self.theme.colors.states.successContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_danger_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .danger, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.error,
             self.theme.colors.base.surface,
             self.theme.colors.states.errorContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_surface_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(for: .surface, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.base.onSurface,
             self.theme.colors.base.surface,
             self.theme.colors.states.surfacePressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    // MARK: - Helper Functions
    func sut() -> ButtonVariantGetContrastUseCase {
        return ButtonVariantGetContrastUseCase()
    }
}
