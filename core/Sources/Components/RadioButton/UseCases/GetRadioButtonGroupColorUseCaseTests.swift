//
//  GetRadioButtonGroupColorUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 06.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

@testable import SparkCore
import XCTest

final class GetRadioButtonGroupColorUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_warning() {
        // Given
        let sut = GetRadioButtonGroupColorUseCase()
        let colors = ColorsGeneratedMock()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()

        // When
        let colorToken = sut.execute(colors: colors, state: .warning)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.onAlertContainer.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.onAlertContainer.color)
    }

    func test_error() {
        // Given
        let sut = GetRadioButtonGroupColorUseCase()
        let colors = ColorsGeneratedMock()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()

        // When
        let colorToken = sut.execute(colors: colors, state: .error)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.error.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.error.color)
    }

    func test_success() {
        // Given
        let sut = GetRadioButtonGroupColorUseCase()
        let colors = ColorsGeneratedMock()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()

        // When
        let colorToken = sut.execute(colors: colors, state: .success)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.feedback.success.uiColor)
        XCTAssertEqual(colorToken.color, colors.feedback.success.color)
    }

    func test_enabled() {
        // Given
        let sut = GetRadioButtonGroupColorUseCase()
        let colors = ColorsGeneratedMock()
        colors.primary = ColorsPrimaryGeneratedMock.mocked()

        // When
        let colorToken = sut.execute(colors: colors, state: .enabled)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.primary.primaryContainer.uiColor)
        XCTAssertEqual(colorToken.color, colors.primary.primaryContainer.color)
    }

    func test_disabled() {
        // Given
        let sut = GetRadioButtonGroupColorUseCase()
        let colors = ColorsGeneratedMock()
        colors.primary = ColorsPrimaryGeneratedMock.mocked()

        // When
        let colorToken = sut.execute(colors: colors, state: .disabled)

        // Then
        XCTAssertEqual(colorToken.uiColor, colors.primary.primaryContainer.uiColor)
        XCTAssertEqual(colorToken.color, colors.primary.primaryContainer.color)
    }
}
