//
//  ButtonVariantFilledUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonVariantFilledUseCaseTests: ButtonVariantUseCaseTests {

    // MARK: - Tests
    func test_primary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .primary, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.primary.onPrimary,
             self.theme.colors.primary.primary,
             self.theme.colors.states.primaryPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_secondary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .secondary, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.secondary.onSecondary,
             self.theme.colors.secondary.secondary,
             self.theme.colors.states.secondaryPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_neutral_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .neutral, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onNeutral,
             self.theme.colors.feedback.neutral,
             self.theme.colors.states.neutralPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_alert_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .alert, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onAlert,
             self.theme.colors.feedback.alert,
             self.theme.colors.states.alertPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_success_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .success, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onSuccess,
             self.theme.colors.feedback.success,
             self.theme.colors.states.successPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_danger_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .danger, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onError,
             self.theme.colors.feedback.error,
             self.theme.colors.states.errorPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_surface_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(for: .surface, on: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.textColor,
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
    func sut() -> ButtonVariantFilledUseCase {
        return ButtonVariantFilledUseCase()
    }
}
