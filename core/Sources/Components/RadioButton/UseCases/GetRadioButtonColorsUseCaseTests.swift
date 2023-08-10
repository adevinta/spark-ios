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
    var main: ColorsMainGeneratedMock!
    var base: ColorsBaseGeneratedMock!
    var accent: ColorsAccentGeneratedMock!
    var basic: ColorsBasicGeneratedMock!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        // Given
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        let base = ColorsBaseGeneratedMock()
        let main = ColorsMainGeneratedMock()
        let feedback = ColorsFeedbackGeneratedMock()
        let accent = ColorsAccentGeneratedMock()
        let basic = ColorsBasicGeneratedMock()

        colors.base = base
        colors.feedback = feedback
        colors.main = main
        colors.accent = accent
        colors.basic = basic

        theme.colors = colors

        self.theme = theme
        self.base = base
        self.main = main
        self.feedback = feedback
        self.accent = accent
        self.basic = basic
        self.sut = GetRadioButtonColorsUseCase()
    }

    // MARK: - Tests
    func test_enabled_colors_when_button_is_not_selected() throws {
        // Given
        let mainContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let outline = ColorTokenGeneratedMock()

        mainContainer.color = .red
        onSurface.color = .green
        outline.color = .blue

        self.main.mainContainer = mainContainer
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
        let mainContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let outline = ColorTokenGeneratedMock()

        mainContainer.color = .yellow
        onSurface.color = .gray
        outline.color = .purple

        self.main.mainContainer = mainContainer
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
             .clear])
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

    func test_accent_colors_when_button_is_not_selected() throws {
        // Given
        let outline = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let accentContainer = ColorTokenGeneratedMock()

        outline.color = .gray
        onSurface.color = .pink
        accentContainer.color = .green

        self.base.outline = outline
        self.base.onSurface = onSurface
        self.accent.accentContainer = accentContainer

        let colors = self.sut.execute(theme: self.theme,
                                      state: .accent,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.green,
             .pink,
             .gray,
             .clear])
    }

    func test_basic_colors_when_button_is_not_selected() throws {
        // Given
        let outline = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()
        let basicContainer = ColorTokenGeneratedMock()

        outline.color = .gray
        onSurface.color = .red
        basicContainer.color = .blue

        self.base.outline = outline
        self.base.onSurface = onSurface
        self.basic.basicContainer = basicContainer

        let colors = self.sut.execute(theme: self.theme,
                                      state: .basic,
                                      isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.blue,
             .red,
             .gray,
             .clear])
    }

    func test_enabled_colors_when_button_is_selected() throws {
        // Given
        let main = ColorTokenGeneratedMock()
        let mainContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        main.color = .blue
        onSurface.color = .green
        mainContainer.color = .gray

        self.main.main = main
        self.main.mainContainer = mainContainer
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
        let main = ColorTokenGeneratedMock()
        let mainContainer = ColorTokenGeneratedMock()
        let onSurface = ColorTokenGeneratedMock()

        main.color = .blue
        mainContainer.color = .black
        onSurface.color = .white

        self.main.main = main
        self.main.mainContainer = mainContainer
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

    func test_accent_colors_when_button_is_selected() throws {
        // Given
        let onSurface = ColorTokenGeneratedMock()
        let accent = ColorTokenGeneratedMock()
        let accentContainer = ColorTokenGeneratedMock()

        onSurface.color = .yellow
        accent.color = .red
        accentContainer.color = .green

        self.base.onSurface = onSurface
        self.accent.accent = accent
        self.accent.accentContainer = accentContainer

        let colors = self.sut.execute(theme: self.theme,
                                      state: .accent,
                                      isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.green,
             .yellow,
             .red,
             .red])
    }

    func test_basic_colors_when_button_is_selected() throws {
        // Given
        let onSurface = ColorTokenGeneratedMock()
        let basic = ColorTokenGeneratedMock()
        let basicContainer = ColorTokenGeneratedMock()

        onSurface.color = .red
        basic.color = .purple
        basicContainer.color = .blue

        self.base.onSurface = onSurface
        self.basic.basic = basic
        self.basic.basicContainer = basicContainer

        let colors = self.sut.execute(theme: self.theme,
                                      state: .basic,
                                      isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill].map(\.color),
            [Color.blue,
             .red,
             .purple,
             .purple])
    }
}
