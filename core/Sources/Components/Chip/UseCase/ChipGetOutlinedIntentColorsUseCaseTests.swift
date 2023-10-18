//
//  ChipGetOutlinedIntentColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 09.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest

@testable import SparkCore

final class ChipGetOutlinedIntentColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    private var sut: ChipGetOutlinedIntentColorsUseCase!
    private var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock()

        self.sut = ChipGetOutlinedIntentColorsUseCase()
        let dims = DimsGeneratedMock()
        dims.dim5 = 0.55
        self.theme.dims = dims
    }

    // MARK: - Tests
    func test_main_color() {
        // Given
        self.setupMainColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .main)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.main.main,
                colors.main.main,
                colors.main.onMainContainer,
                ColorTokenDefault.clear,
                colors.main.main.opacity(theme.dims.dim5),
                colors.main.mainContainer
            ].map(\.uiColor))
    }

    func test_support_color() {
        // Given
        self.setupSupportColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .support)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.support.support,
                colors.support.support,
                colors.support.onSupportContainer,
                ColorTokenDefault.clear,
                colors.support.support.opacity(theme.dims.dim5),
                colors.support.supportContainer
            ].map(\.uiColor))
    }

    func test_basic_color() {
        // Given
        self.setupBasicColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .basic)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.basic.basic,
                colors.basic.basic,
                colors.basic.onBasicContainer,
                ColorTokenDefault.clear,
                colors.basic.basic.opacity(theme.dims.dim5),
                colors.basic.basicContainer
            ].map(\.uiColor))
    }

    func test_surface_color() {
        // Given
        self.setupSurfaceColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .surface)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.base.surface,
                colors.base.surface,
                colors.base.onSurface,
                ColorTokenDefault.clear,
                colors.base.surface.opacity(theme.dims.dim5),
                colors.base.surface
            ].map(\.uiColor))
    }

    func test_neutral_color() {
        // Given
        self.setupFeedbackNeutralColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .neutral)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.feedback.neutral,
                colors.feedback.neutral,
                colors.feedback.onNeutralContainer,
                ColorTokenDefault.clear,
                colors.feedback.neutral.opacity(theme.dims.dim5),
                colors.feedback.neutralContainer
            ].map(\.uiColor))
    }

    func test_info_color() {
        // Given
        self.setupFeedbackInfoColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .info)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.feedback.info,
                colors.feedback.info,
                colors.feedback.onInfoContainer,
                ColorTokenDefault.clear,
                colors.feedback.info.opacity(theme.dims.dim5),
                colors.feedback.infoContainer
            ].map(\.uiColor))
    }

    func test_alert_color() {
        // Given
        self.setupFeedbackAlertColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .alert)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.feedback.alert,
                colors.feedback.onAlertContainer,
                colors.feedback.onAlertContainer,
                ColorTokenDefault.clear,
                colors.feedback.alert.opacity(theme.dims.dim5),
                colors.feedback.alertContainer
            ].map(\.uiColor))
    }

    func test_danger_color() {
        // Given
        self.setupFeedbackDangerColors()
        let colors = self.theme.colors

        // When
        let chipIntentColors = self.sut.execute(theme: self.theme, intent: .danger)

        // Then
        XCTAssertEqual(
            [
                chipIntentColors.border,
                chipIntentColors.text,
                chipIntentColors.selectedText,
                chipIntentColors.background,
                chipIntentColors.pressedBackground,
                chipIntentColors.selectedBackground,
                chipIntentColors.disabledBackground
            ].compacted().map(\.uiColor),
            [
                colors.feedback.error,
                colors.feedback.error,
                colors.feedback.onErrorContainer,
                ColorTokenDefault.clear,
                colors.feedback.error.opacity(theme.dims.dim5),
                colors.feedback.errorContainer
            ].map(\.uiColor))
    }

    // MARK: - Private helpers
    private func setupMainColors() {
        let main = ColorsMainGeneratedMock()
        main.main = ColorTokenGeneratedMock.random()
        main.onMain = ColorTokenGeneratedMock.random()
        main.mainContainer = ColorTokenGeneratedMock.random()
        main.onMainContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.main = main
        self.theme.colors = colors
    }

    private func setupSupportColors() {
        let support = ColorsSupportGeneratedMock()
        support.support = ColorTokenGeneratedMock.random()
        support.onSupport = ColorTokenGeneratedMock.random()
        support.supportContainer = ColorTokenGeneratedMock.random()
        support.onSupportContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.support = support
        self.theme.colors = colors
    }

    private func setupBasicColors() {
        let basic = ColorsBasicGeneratedMock()
        basic.basic = ColorTokenGeneratedMock.random()
        basic.onBasic = ColorTokenGeneratedMock.random()
        basic.basicContainer = ColorTokenGeneratedMock.random()
        basic.onBasicContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.basic = basic
        self.theme.colors = colors
    }

    private func setupSurfaceColors() {
        let base = ColorsBaseGeneratedMock()
        base.surface = ColorTokenGeneratedMock.random()
        base.onSurface = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.base = base
        self.theme.colors = colors
    }

    private func setupFeedbackNeutralColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.neutral = ColorTokenGeneratedMock.random()
        feedback.onNeutral = ColorTokenGeneratedMock.random()
        feedback.neutralContainer = ColorTokenGeneratedMock.random()
        feedback.onNeutralContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        self.theme.colors = colors
    }

    private func setupFeedbackInfoColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.info = ColorTokenGeneratedMock.random()
        feedback.onInfo = ColorTokenGeneratedMock.random()
        feedback.infoContainer = ColorTokenGeneratedMock.random()
        feedback.onInfoContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        self.theme.colors = colors
    }

    private func setupFeedbackAlertColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.alert = ColorTokenGeneratedMock.random()
        feedback.onAlert = ColorTokenGeneratedMock.random()
        feedback.alertContainer = ColorTokenGeneratedMock.random()
        feedback.onAlertContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        self.theme.colors = colors
    }

    private func setupFeedbackDangerColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.error = ColorTokenGeneratedMock.random()
        feedback.onError = ColorTokenGeneratedMock.random()
        feedback.errorContainer = ColorTokenGeneratedMock.random()
        feedback.onErrorContainer = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        self.theme.colors = colors
    }
}
