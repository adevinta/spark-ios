//
//  GetRadioButtonColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import SwiftUI
import XCTest

final class GetRadioButtonColorUseCaseTests: XCTestCase {


    var sut: GetRadioButtonColorsUseCase!

    override func setUp() {
        super.setUp()

        // Given
        self.sut = GetRadioButtonColorsUseCase(theme: ThemeGeneratedMock.mock)
    }

    // MARK: - Tests
    func test_enabled_colors_when_button_is_not_selected() throws {

        // When
        let colors = self.sut.execute(state: .enabled, isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.subLabel].map(\.?.color),
            [Color.primaryContainer,
             .onSurface,
             .outline,
             nil
            ])

        XCTAssertNil(colors.fill)
    }

    func test_disabled_colors_when_button_is_not_selected() throws {
        // When
        let colors = self.sut.execute(state: .disabled, isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.subLabel].map(\.?.color),
            [Color.primaryContainer,
             .onSurface,
             .outline,
             nil
            ])

        XCTAssertNil(colors.fill)
    }

    func test_error_colors_when_button_is_not_selected() throws {
        // When
        let colors = self.sut.execute(state: .error(message: "Error"), isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.subLabel].map(\.?.color),
            [Color.errorContainer,
             .onSurface,
             .error,
             .error
            ])

        XCTAssertNil(colors.fill)
    }

    func test_warn_colors_when_button_is_not_selected() throws {
        // When
        let colors = self.sut.execute(state: .warning(message: "Error"), isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.subLabel].map(\.?.color),
            [Color.alertContainer,
             .onSurface,
             .alert,
             .onAlertContainer
            ])

        XCTAssertNil(colors.fill)
    }

    func test_success_colors_when_button_is_not_selected() throws {
        // When
        let colors = self.sut.execute(state: .success(message: "Error"), isSelected: false)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.subLabel].map(\.?.color),
            [Color.successContainer,
             .onSurface,
             .success,
             .success
            ])

        XCTAssertNil(colors.fill)
    }

    func test_enabled_colors_when_button_is_selected() throws {
        // When
        let colors = self.sut.execute(state: .enabled, isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill,
             colors.subLabel].map(\.?.color),
            [Color.primaryContainer,
             .onSurface,
             .primary,
             .primary,
             nil
            ])
    }

    func test_disabled_colors_when_button_is_selected() throws {
        // When
        let colors = self.sut.execute(state: .disabled, isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill,
             colors.subLabel].map(\.?.color),
            [Color.primaryContainer,
             .onSurface,
             .primary,
             .primary,
             nil
            ])

    }

    func test_error_colors_when_button_is_selected() throws {
        // When
        let colors = self.sut.execute(state: .error(message: "Error"), isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill,
             colors.subLabel].map(\.?.color),
            [Color.errorContainer,
             .onSurface,
             .error,
             .error,
             .error
            ])
    }

    func test_warn_colors_when_button_is_selected() throws {
        // When
        let colors = sut.execute(state: .warning(message: "Error"), isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill,
             colors.subLabel].map(\.?.color),
            [Color.alertContainer,
             .onSurface,
             .alert,
             .alert,
             .onAlertContainer
            ])

    }

    func test_success_colors_when_button_is_selected() throws {
        // When
        let colors = sut.execute(state: .success(message: "Error"), isSelected: true)

        // Then
        XCTAssertEqual(
            [colors.halo,
             colors.label,
             colors.button,
             colors.fill,
             colors.subLabel].map(\.?.color),
            [Color.successContainer,
             .onSurface,
             .success,
             .success,
             .success
            ])
    }

}

// MARK: - Helper Extensions
private extension Color {
    static let primary = Color(hue: 235/360, saturation: 1, brightness: 1)
    static let primaryContainer = Color(hue: 235/360, saturation: 0.8, brightness: 1)
    static let onSurface = Color(hue: 200/360, saturation: 1, brightness: 0.5)
    static let outline = Color(hue: 1, saturation: 0.1, brightness: 0.1)
    static let alert = Color(hue: 50/360, saturation: 1, brightness: 1)
    static let onAlertContainer = Color(hue: 50/360, saturation: 0.75, brightness: 0.75)
    static let alertContainer = Color(hue: 50/360, saturation: 0.5, brightness: 0.5)
    static let error = Color(hue: 1/360, saturation: 1, brightness: 1)
    static let errorContainer = Color(hue: 1/360, saturation: 0.5, brightness: 0.5)
    static let success = Color(hue: 100/360, saturation: 1, brightness: 1)
    static let successContainer = Color(hue: 100/360, saturation: 0.5, brightness: 0.5)
}

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
        let base = ColorsBaseGeneratedMock()

        base.outline = .mock(.outline)
        base.onSurface = .mock(.onSurface)

        let feedback = ColorsFeedbackGeneratedMock()
        feedback.alert = .mock(.alert)
        feedback.alertContainer = .mock(.alertContainer)
        feedback.onAlertContainer = .mock(.onAlertContainer)

        feedback.error = .mock(.error)
        feedback.errorContainer = .mock(.errorContainer)
        feedback.success = .mock(.success)
        feedback.successContainer = .mock(.successContainer)

        let primary = ColorsPrimaryGeneratedMock()
        primary.primaryContainer = .mock(.primaryContainer)
        primary.primary = .mock(.primary)

        colors.base = base
        colors.primary = primary
        colors.feedback = feedback

        return colors
    }
}

private extension ColorToken where Self == ColorTokenGeneratedMock {
    static func mock(_ color: Color) -> Self {
        let mock = ColorTokenGeneratedMock()
        mock.color = color
        return mock
    }
}
