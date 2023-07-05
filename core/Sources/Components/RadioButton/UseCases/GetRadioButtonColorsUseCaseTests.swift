//
//  GetRadioButtonColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI
import XCTest

final class GetRadioButtonColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: GetRadioButtonColorsUseCase!
    var feedback: ColorsFeedbackGeneratedMock!
    var primary: ColorsPrimaryGeneratedMock!
    var base: ColorsBaseGeneratedMock!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        // Given
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        let base = ColorsBaseGeneratedMock()
        let primary = ColorsPrimaryGeneratedMock()
        let feedback = ColorsFeedbackGeneratedMock()

        colors.base = base
        colors.feedback = feedback
        colors.primary = primary

        theme.colors = colors

        self.theme = theme
        self.base = base
        self.primary = primary
        self.feedback = feedback
        self.sut = GetRadioButtonColorsUseCase()
    }

    // MARK: - Tests
    func test_enabled_colors_when_button_is_not_selected() throws {
        // Given
        let primaryContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let outline = ColorTokenGeneratedMock()

        primaryContainer.color = .red
        onSurface.color = .green
        outline.color = .blue

        self.primary.primaryContainer = primaryContainer
        self.base.onSurface = onSurface
        self.base.outline = outline

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .enabled,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.red,
             .green,
             .blue,
             .clear])
    }

    func test_disabled_colors_when_button_is_not_selected() throws {
        // Given
        let primaryContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let outline = ColorTokenGeneratedMock()

        primaryContainer.color = .yellow
        onSurface.color = .gray
        outline.color = .purple

        self.primary.primaryContainer = primaryContainer
        self.base.onSurface = onSurface
        self.base.outline = outline

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .disabled,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.yellow,
             .gray,
             .purple,
             .clear])
    }

    func test_error_colors_when_button_is_not_selected() throws {
        // Given
        let error = ColorTokenGeneratedMock()
        let errorContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        error.color = .red
        errorContainer.color = .orange
        onSurface.color = .purple

        self.feedback.error = error
        self.feedback.errorContainer = errorContainer
        self.base.onSurface = onSurface

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .error,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.orange,
             .purple,
             .red,
             .red])
    }

    func test_warn_colors_when_button_is_not_selected() throws {
        // Given
        let alert = ColorTokenGeneratedMock()
        let onAlertContainer = ColorTokenGeneratedMock()
        let alertContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        alert.color = .purple
        onAlertContainer.color = .pink
        alertContainer.color = .gray
        onSurface.color = .green

        self.feedback.alert = alert
        self.feedback.onAlertContainer = onAlertContainer
        self.feedback.alertContainer = alertContainer
        self.base.onSurface = onSurface

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .warning,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.gray,
             .green,
             .purple,
             .clear])
    }

    func test_success_colors_when_button_is_not_selected() throws {
        let success = ColorTokenGeneratedMock()
        let successContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        success.color = .green
        successContainer.color = .blue
        onSurface.color = .gray

        self.feedback.success = success
        self.feedback.successContainer = successContainer
        self.base.onSurface = onSurface

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .success,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.blue,
             .gray,
             .green,
             .clear])
    }

    func test_enabled_colors_when_button_is_selected() throws {
        // Given
        let primary = ColorTokenGeneratedMock()
        let primaryContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        primary.color = .blue
        onSurface.color = .green
        primaryContainer.color = .gray

        self.primary.primary = primary
        self.primary.primaryContainer = primaryContainer
        self.base.onSurface = onSurface
        
        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .enabled,
                                      isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.gray,
             .green,
             .blue,
             .blue])
    }

    func test_disabled_colors_when_button_is_selected() throws {
        // Given
        let primary = ColorTokenGeneratedMock()
        let primaryContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        primary.color = .blue
        primaryContainer.color = .black
        onSurface.color = .white

        self.primary.primary = primary
        self.primary.primaryContainer = primaryContainer
        self.base.onSurface = onSurface

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .disabled,
                                      isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.black,
             .white,
             .blue,
             .blue])
    }

    func test_error_colors_when_button_is_selected() throws {
        // Given
        let error = ColorTokenGeneratedMock()
        let errorContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        error.color = .green
        errorContainer.color = .white
        onSurface.color = .orange

        self.feedback.error = error
        self.feedback.errorContainer = errorContainer
        self.base.onSurface = onSurface

        // When
        let colors = self.sut.execute(theme: self.theme,
                                      state: .error,
                                      isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.white,
             .orange,
             .green,
             .green])
    }

    func test_warn_colors_when_button_is_selected() throws {
        // Given
        let alert = ColorTokenGeneratedMock()
        let onAlertContainer = ColorTokenGeneratedMock()
        let alertContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        alert.color = .purple
        onAlertContainer.color = .pink
        alertContainer.color = .gray
        onSurface.color = .green

        self.feedback.alert = alert
        self.feedback.onAlertContainer = onAlertContainer
        self.feedback.alertContainer = alertContainer
        self.base.onSurface = onSurface

        // When
        let colors = sut.execute(theme: self.theme,
                                 state: .warning,
                                 isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.gray,
             .green,
             .purple,
             .purple])
    }

    func test_success_colors_when_button_is_selected() throws {
        // Given
        let success = ColorTokenGeneratedMock()
        let successContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        success.color = .green
        successContainer.color = .white
        onSurface.color = .gray

        self.base.onSurface = onSurface
        self.feedback.success = success
        self.feedback.successContainer = successContainer
        
        // When
        let colors = sut.execute(theme: self.theme,
                                 state: .success,
                                 isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.white,
             .gray,
             .green,
             .green])
    }
}
