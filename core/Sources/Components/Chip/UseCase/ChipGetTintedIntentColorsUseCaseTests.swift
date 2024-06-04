//
//  ChipGetTintedIntentColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by michael.zimmermann on 11.10.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
@_spi(SI_SPI) import SparkCommon
import SparkThemingTesting

final class ChipGetTintedIntentColorsUseCaseTests: XCTestCase {

    // MARK: - Properties
    private var sut: ChipGetTintedIntentColorsUseCase!
    private var theme: ThemeGeneratedMock!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock()

        self.sut = ChipGetTintedIntentColorsUseCase()
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
                colors.main.mainContainer,
                colors.main.onMainContainer,
                colors.main.onMain,
                colors.main.mainContainer,
                colors.states.mainContainerPressed,
                colors.main.main
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
                colors.support.supportContainer,
                colors.support.onSupportContainer,
                colors.support.onSupport,
                colors.support.supportContainer,
                colors.states.supportContainerPressed,
                colors.support.support
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
                colors.basic.basicContainer,
                colors.basic.onBasicContainer,
                colors.basic.onBasic,
                colors.basic.basicContainer,
                colors.states.basicContainerPressed,
                colors.basic.basic
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
                ColorTokenDefault.clear,
                colors.base.surfaceInverse,
                colors.base.onSurface,
                colors.base.surface.opacity(theme.dims.dim1),
                colors.states.surfacePressed,
                colors.base.surface,
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
                colors.feedback.neutralContainer,
                colors.feedback.onNeutralContainer,
                colors.feedback.onNeutral,
                colors.feedback.neutralContainer,
                colors.states.neutralContainerPressed,
                colors.feedback.neutral
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
                colors.feedback.infoContainer,
                colors.feedback.onInfoContainer,
                colors.feedback.onInfo,
                colors.feedback.infoContainer,
                colors.states.infoContainerPressed,
                colors.feedback.info
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
                colors.feedback.alertContainer,
                colors.feedback.onAlertContainer,
                colors.feedback.onAlert,
                colors.feedback.alertContainer,
                colors.states.alertContainerPressed,
                colors.feedback.alert
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
                colors.feedback.errorContainer,
                colors.feedback.onErrorContainer,
                colors.feedback.onError,
                colors.feedback.errorContainer,
                colors.states.errorContainerPressed,
                colors.feedback.error
            ].map(\.uiColor))
    }

    // MARK: - Private helpers
    private func setupMainColors() {
        let main = ColorsMainGeneratedMock()
        main.main = ColorTokenGeneratedMock.random()
        main.onMain = ColorTokenGeneratedMock.random()
        main.mainContainer = ColorTokenGeneratedMock.random()
        main.onMainContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.mainContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.main = main
        colors.states = states
        self.theme.colors = colors
    }

    private func setupSupportColors() {
        let support = ColorsSupportGeneratedMock()
        support.support = ColorTokenGeneratedMock.random()
        support.onSupport = ColorTokenGeneratedMock.random()
        support.supportContainer = ColorTokenGeneratedMock.random()
        support.onSupportContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.supportContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.support = support
        colors.states = states
        self.theme.colors = colors
    }

    private func setupBasicColors() {
        let basic = ColorsBasicGeneratedMock()
        basic.basic = ColorTokenGeneratedMock.random()
        basic.onBasic = ColorTokenGeneratedMock.random()
        basic.basicContainer = ColorTokenGeneratedMock.random()
        basic.onBasicContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.basicContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.basic = basic
        colors.states = states
        self.theme.colors = colors
    }

    private func setupSurfaceColors() {
        let base = ColorsBaseGeneratedMock()
        base.surface = ColorTokenGeneratedMock.random()
        base.onSurface = ColorTokenGeneratedMock.random()
        base.surfaceInverse = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.surfacePressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.base = base
        colors.states = states
        self.theme.colors = colors
    }

    private func setupFeedbackNeutralColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.neutral = ColorTokenGeneratedMock.random()
        feedback.onNeutral = ColorTokenGeneratedMock.random()
        feedback.neutralContainer = ColorTokenGeneratedMock.random()
        feedback.onNeutralContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.neutralContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        colors.states = states
        self.theme.colors = colors
    }

    private func setupFeedbackInfoColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.info = ColorTokenGeneratedMock.random()
        feedback.onInfo = ColorTokenGeneratedMock.random()
        feedback.infoContainer = ColorTokenGeneratedMock.random()
        feedback.onInfoContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.infoContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        colors.states = states
        self.theme.colors = colors
    }

    private func setupFeedbackAlertColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.alert = ColorTokenGeneratedMock.random()
        feedback.onAlert = ColorTokenGeneratedMock.random()
        feedback.alertContainer = ColorTokenGeneratedMock.random()
        feedback.onAlertContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.alertContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        colors.states = states
        self.theme.colors = colors
    }

    private func setupFeedbackDangerColors() {
        let feedback = ColorsFeedbackGeneratedMock()
        feedback.error = ColorTokenGeneratedMock.random()
        feedback.onError = ColorTokenGeneratedMock.random()
        feedback.errorContainer = ColorTokenGeneratedMock.random()
        feedback.onErrorContainer = ColorTokenGeneratedMock.random()

        let states = ColorsStatesGeneratedMock()
        states.errorContainerPressed = ColorTokenGeneratedMock.random()

        let colors = ColorsGeneratedMock()
        colors.feedback = feedback
        colors.states = states
        self.theme.colors = colors
    }
}
