//
//  ButtonGetVariantTintedUseCaseTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 16.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class ButtonGetVariantTintedUseCaseTests: ButtonVariantUseCaseTests {

    // MARK: - Tests
    func test_primary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .primary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.primary.onPrimaryContainer,
             self.theme.colors.primary.primaryContainer,
             self.theme.colors.states.primaryContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_secondary_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .secondary, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.secondary.onSecondaryContainer,
             self.theme.colors.secondary.secondaryContainer,
             self.theme.colors.states.secondaryContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_neutral_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .neutral, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onNeutralContainer,
             self.theme.colors.feedback.neutralContainer,
             self.theme.colors.states.neutralContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_alert_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .alert, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onAlertContainer,
             self.theme.colors.feedback.alertContainer,
             self.theme.colors.states.alertContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_success_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .success, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onSuccessContainer,
             self.theme.colors.feedback.successContainer,
             self.theme.colors.states.successContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_danger_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .danger, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.feedback.onErrorContainer,
             self.theme.colors.feedback.errorContainer,
             self.theme.colors.states.errorContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_surface_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.colors(forIntentColor: .surface, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.base.onBackgroundVariant,
             self.theme.colors.base.backgroundVariant,
             self.theme.colors.states.surfacePressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    // MARK: - Helper Functions
    func sut() -> ButtonGetVariantTintedUseCase {
        return ButtonGetVariantTintedUseCase()
    }
}
