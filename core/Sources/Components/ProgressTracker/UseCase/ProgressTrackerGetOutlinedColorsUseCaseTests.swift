//
//  ProgressTrackerGetOutlinedColorsUseCaseTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 18.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore
import SparkThemingTesting

final class ProgressTrackerGetOutlinedColorsUseCaseTests: XCTestCase {

    var sut: ProgressTrackerGetOutlinedColorsUseCase!
    var colors: ColorsGeneratedMock!

    // MARK: - Setup
    override func setUp()  {
        super.setUp()

        self.colors = ColorsGeneratedMock.mocked()
        self.sut = ProgressTrackerGetOutlinedColorsUseCase()
    }

    // MARK: - Tests
    func test_selected_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN
            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .selected)

            // THEN
            XCTAssertEqual(colors, intent.selectedColors(self.colors), "Selected colors for intent \(intent) not as expected")
        }
    }

    func test_enabled_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .normal)

            // THEN
            XCTAssertEqual(colors, intent.enabledColors(self.colors), "Enabled colors for intent \(intent) not as expected")
        }
    }

    func test_pressed_colors() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .pressed)

            // THEN
            XCTAssertEqual(colors, intent.pressedColors(self.colors), "Pressed colors for intent \(intent) not as expected")
        }
    }

    func test_colors_disabled() {
        // GIVEN

        for intent in ProgressTrackerIntent.allCases {
            // WHEN

            let colors = self.sut.execute(colors: self.colors, intent: intent, state: .disabled)

            let expectedColors = intent.enabledColors(self.colors)

            // THEN
            XCTAssertEqual(colors, expectedColors, "Disabled colors for intent \(intent) not as expected")
        }
    }
}

// MARK: Private helpers
private extension ProgressTrackerIntent {

    func selectedColors(_ colors: Colors) -> ProgressTrackerColors {
        switch self {
        case .accent:
            return .init(
                background: colors.accent.accentContainer,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.feedback.alertContainer,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.basic.basicContainer,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.feedback.errorContainer,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.feedback.infoContainer,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.main.mainContainer,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.feedback.neutralContainer,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.feedback.successContainer,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.support.supportContainer,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }

    func enabledColors(_ colors: Colors) -> ProgressTrackerColors {
        switch self {
        case .accent:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: ColorTokenDefault.clear,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }

    func pressedColors(_ colors: Colors) -> ProgressTrackerColors {
        switch self {
        case .accent:
            return .init(
                background: colors.states.accentContainerPressed,
                outline: colors.accent.accent,
                content: colors.accent.onAccentContainer)
        case .alert:
            return .init(
                background: colors.states.alertContainerPressed,
                outline: colors.feedback.alert,
                content: colors.feedback.onAlertContainer)
        case .basic:
            return .init(
                background: colors.states.basicContainerPressed,
                outline: colors.basic.basic,
                content: colors.basic.onBasicContainer)
        case .danger:
            return .init(
                background: colors.states.errorContainerPressed,
                outline: colors.feedback.error,
                content: colors.feedback.onErrorContainer)
        case .info:
            return .init(
                background: colors.states.infoContainerPressed,
                outline: colors.feedback.info,
                content: colors.feedback.onInfoContainer)
        case .main:
            return .init(
                background: colors.states.mainContainerPressed,
                outline: colors.main.main,
                content: colors.main.onMainContainer)
        case .neutral:
            return .init(
                background: colors.states.neutralContainerPressed,
                outline: colors.feedback.neutral,
                content: colors.feedback.onNeutralContainer)
        case .success:
            return .init(
                background: colors.states.successContainerPressed,
                outline: colors.feedback.success,
                content: colors.feedback.onSuccessContainer)
        case .support:
            return .init(
                background: colors.states.supportContainerPressed,
                outline: colors.support.support,
                content: colors.support.onSupportContainer)
        }
    }
}

