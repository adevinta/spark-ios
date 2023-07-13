//
//  ButtonGetVariantOutlinedUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetVariantOutlinedUseCaseTests: ButtonVariantUseCaseTests {

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
             self.theme.colors.primary.primary.opacity(self.theme.dims.dim5),
             self.theme.colors.primary.primary,
             self.theme.colors.primary.primary
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
             self.theme.colors.secondary.secondary.opacity(self.theme.dims.dim5),
             self.theme.colors.secondary.secondary,
             self.theme.colors.secondary.secondary
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
             self.theme.colors.feedback.neutral.opacity(self.theme.dims.dim5),
             self.theme.colors.feedback.neutral,
             self.theme.colors.feedback.neutral
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
             self.theme.colors.feedback.alert.opacity(self.theme.dims.dim5),
             self.theme.colors.feedback.alert,
             self.theme.colors.feedback.alert
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
             self.theme.colors.feedback.success.opacity(self.theme.dims.dim5),
             self.theme.colors.feedback.success,
             self.theme.colors.feedback.success
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
             self.theme.colors.feedback.error.opacity(self.theme.dims.dim5),
             self.theme.colors.feedback.error,
             self.theme.colors.feedback.error
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
            [self.theme.colors.base.surface,
             self.theme.colors.base.surfaceInverse,
             self.theme.colors.base.surface.opacity(self.theme.dims.dim5),
             self.theme.colors.base.surface,
             self.theme.colors.base.surface
            ].map(\.color))
    }

    // MARK: - Helper Functions
    func sut() -> ButtonGetVariantOutlinedUseCase {
        return ButtonGetVariantOutlinedUseCase()
    }
}
