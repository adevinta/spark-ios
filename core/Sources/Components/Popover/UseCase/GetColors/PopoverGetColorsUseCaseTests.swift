//
//  PopoverGetColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 25/06/2024.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class PopoverGetColorsUseCaseTests: XCTestCase {

    private let theme = ThemeGeneratedMock.mocked()
    private let useCase = PopoverGetColorsUseCase()

    func test_surface() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .surface)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.base.surface), "Wrong background color for intent .surface")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.base.onSurface), "Wrong foreground color for intent .surface")
    }

    func test_main() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .main)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.main.mainContainer), "Wrong background color for intent .main")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.main.onMainContainer), "Wrong foreground color for intent .main")
    }

    func test_support() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .support)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.support.supportContainer), "Wrong background color for intent .support")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.support.onSupportContainer), "Wrong foreground color for intent .support")
    }

    func test_accent() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .accent)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.accent.accentContainer), "Wrong background color for intent .accent")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.accent.onAccentContainer), "Wrong foreground color for intent .accent")
    }

    func test_basic() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .basic)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.basic.basicContainer), "Wrong background color for intent .basic")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.basic.onBasicContainer), "Wrong foreground color for intent .basic")
    }

    func test_success() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .success)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.successContainer), "Wrong background color for intent .success")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.feedback.onSuccessContainer), "Wrong foreground color for intent .success")
    }

    func test_alert() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .alert)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.alertContainer), "Wrong background color for intent .alert")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.feedback.onAlertContainer), "Wrong foreground color for intent .alert")
    }

    func test_error() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .error)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.errorContainer), "Wrong background color for intent .error")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.feedback.onErrorContainer), "Wrong foreground color for intent .error")
    }

    func test_info() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .info)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.infoContainer), "Wrong background color for intent .info")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.feedback.onInfoContainer), "Wrong foreground color for intent .info")
    }

    func test_neutral() {
        // WHEN
        let colors = self.useCase.execute(colors: self.theme.colors, intent: .neutral)

        // THEN
        XCTAssertTrue(colors.background.equals(self.theme.colors.feedback.neutralContainer), "Wrong background color for intent .neutral")
        XCTAssertTrue(colors.foreground.equals(self.theme.colors.feedback.onNeutralContainer), "Wrong foreground color for intent .neutral")
    }
}
