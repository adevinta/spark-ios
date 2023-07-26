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
    func test_main_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(intent: .primary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.main.main,
             self.theme.colors.base.surface,
             self.theme.colors.main.main.opacity(self.theme.dims.dim5),
             self.theme.colors.main.main,
             self.theme.colors.main.main
            ].map(\.color))
    }

    func test_support_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(intent: .secondary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.support.support,
             self.theme.colors.base.surface,
             self.theme.colors.support.support.opacity(self.theme.dims.dim5),
             self.theme.colors.support.support,
             self.theme.colors.support.support
            ].map(\.color))
    }

    func test_neutral_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(intent: .neutral, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .alert, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .success, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .danger, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .surface, colors: self.theme.colors, dims: self.theme.dims)

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
