//
//  RadioButtonGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtonGetColorsUseCaseTests: XCTestCase {

    // MARK: - Properties

    var sut: RadioButtonGetColorsUseCase!
    var theme: ThemeGeneratedMock!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        // Given
        let theme = ThemeGeneratedMock.mocked()
        self.theme = theme
        self.sut = RadioButtonGetColorsUseCase()
    }

    // MARK: - Tests
    func test_basic_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.base.outline,
            label: colors.base.onBackground,
            halo: colors.basic.basicContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.basic.onBasic
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_danger_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.error,
            label: colors.base.onBackground,
            halo: colors.feedback.errorContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.feedback.onError
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .danger,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_info_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.base.outline,
            label: colors.base.onBackground,
            halo: colors.feedback.infoContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.feedback.onInfo
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .info,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_alert_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.alert,
            label: colors.base.onBackground,
            halo: colors.feedback.alertContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.feedback.onAlert
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .alert,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_success_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.success,
            label: colors.base.onBackground,
            halo: colors.feedback.successContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.feedback.onSuccess
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .success,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_accent_colors_when_button_is_not_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.base.outline,
            label: colors.base.onBackground,
            halo: colors.accent.accentContainer,
            fill: ColorTokenDefault.clear,
            surface: colors.accent.onAccent
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .accent,
            isSelected: false)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_basic_colors_when_button_is_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.basic.basic,
            label: colors.base.onBackground,
            halo: colors.basic.basicContainer,
            fill: colors.basic.basic,
            surface: colors.basic.onBasic
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .basic,
            isSelected: true)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_danger_colors_when_button_is_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.error,
            label: colors.base.onBackground,
            halo: colors.feedback.errorContainer,
            fill: colors.feedback.error,
            surface: colors.feedback.onError
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .danger,
            isSelected: true)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_alert_colors_when_button_is_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.alert,
            label: colors.base.onBackground,
            halo: colors.feedback.alertContainer,
            fill: colors.feedback.alert,
            surface: colors.feedback.onAlert
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .alert,
            isSelected: true)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_success_colors_when_button_is_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.feedback.success,
            label: colors.base.onBackground,
            halo: colors.feedback.successContainer,
            fill: colors.feedback.success,
            surface: colors.feedback.onSuccess
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .success,
            isSelected: true)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

    func test_accent_colors_when_button_is_selected() throws {
        // Given
        let colors = self.theme.colors
        let expectedColors = RadioButtonColors(
            button: colors.accent.accent,
            label: colors.base.onBackground,
            halo: colors.accent.accentContainer,
            fill: colors.accent.accent,
            surface: colors.accent.onAccent
        )

        // When
        let givenColors = self.sut.execute(
            theme: self.theme,
            intent: .accent,
            isSelected: true)

        // Then
        XCTAssertEqual(givenColors, expectedColors)
    }

}
