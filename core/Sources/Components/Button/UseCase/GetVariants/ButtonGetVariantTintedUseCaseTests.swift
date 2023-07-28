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
    func test_main_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(intent: .main, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.main.onMainContainer,
             self.theme.colors.main.mainContainer,
             self.theme.colors.states.mainContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
            ].map(\.color))
    }

    func test_support_colors() throws {
        // Given
        let sut = self.sut()

        // When
        let colors = sut.execute(intent: .support, colors: self.theme.colors, dims: self.theme.dims)

        // Then
        XCTAssertEqual(
            [colors.foregroundColor,
             colors.backgroundColor,
             colors.pressedBackgroundColor,
             colors.borderColor,
             colors.pressedBorderColor].map(\.color),
            [self.theme.colors.support.onSupportContainer,
             self.theme.colors.support.supportContainer,
             self.theme.colors.states.supportContainerPressed,
             ColorTokenDefault.clear,
             ColorTokenDefault.clear
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
        let colors = sut.execute(intent: .alert, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .success, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .danger, colors: self.theme.colors, dims: self.theme.dims)

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
        let colors = sut.execute(intent: .surface, colors: self.theme.colors, dims: self.theme.dims)

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
