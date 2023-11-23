//
//  SliderGetColorsUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by louis.borlee on 23/11/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
@testable import SparkCore

final class SliderGetColorsUseCaseTests: XCTestCase {

    private let theme: Theme = ThemeGeneratedMock.mocked()
    private var colors: Colors {
        return self.theme.colors
    }
    private var dims: Dims {
        return self.theme.dims
    }

    // MARK: - Basic
    func test_execute_intent_basic_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.basic.basic,
            handle: self.colors.basic.basic,
            handleActiveIndicator: self.colors.basic.basicContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .basic,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_basic_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.basic.basic.opacity(self.dims.dim3),
            handle: self.colors.basic.basic.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.basic.basicContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .basic,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Success
    func test_execute_intent_success_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.feedback.success,
            handle: self.colors.feedback.success,
            handleActiveIndicator: self.colors.feedback.successContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .success,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_success_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.feedback.success.opacity(self.dims.dim3),
            handle: self.colors.feedback.success.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.feedback.successContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .success,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Error
    func test_execute_intent_error_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.feedback.error,
            handle: self.colors.feedback.error,
            handleActiveIndicator: self.colors.feedback.errorContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .error,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_error_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.feedback.error.opacity(self.dims.dim3),
            handle: self.colors.feedback.error.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.feedback.errorContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .error,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Alert
    func test_execute_intent_alert_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.feedback.alert,
            handle: self.colors.feedback.alert,
            handleActiveIndicator: self.colors.feedback.alertContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .alert,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_alert_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.feedback.alert.opacity(self.dims.dim3),
            handle: self.colors.feedback.alert.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.feedback.alertContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .alert,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Accent
    func test_execute_intent_accent_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.accent.accent,
            handle: self.colors.accent.accent,
            handleActiveIndicator: self.colors.accent.accentContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .accent,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_accent_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.accent.accent.opacity(self.dims.dim3),
            handle: self.colors.accent.accent.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.accent.accentContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .accent,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Main
    func test_execute_intent_main_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.main.main,
            handle: self.colors.main.main,
            handleActiveIndicator: self.colors.main.mainContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .main,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_main_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.main.main.opacity(self.dims.dim3),
            handle: self.colors.main.main.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.main.mainContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .main,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Neutral
    func test_execute_intent_neutral_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.feedback.neutral,
            handle: self.colors.feedback.neutral,
            handleActiveIndicator: self.colors.feedback.neutralContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .neutral,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_neutral_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.feedback.neutral.opacity(self.dims.dim3),
            handle: self.colors.feedback.neutral.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.feedback.neutralContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .neutral,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Support
    func test_execute_intent_support_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.support.support,
            handle: self.colors.support.support,
            handleActiveIndicator: self.colors.support.supportContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .support,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_support_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.support.support.opacity(self.dims.dim3),
            handle: self.colors.support.support.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.support.supportContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .support,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    // MARK: - Info
    func test_execute_intent_info_enabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4),
            indicator: self.colors.feedback.info,
            handle: self.colors.feedback.info,
            handleActiveIndicator: self.colors.feedback.infoContainer
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .info,
                                     isEnabled: true)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }

    func test_execute_intent_info_disabled() {
        // GIVEN
        let useCase = SliderGetColorsUseCase()
        let expectedColors = SliderColors(
            track: self.colors.base.onBackground.opacity(self.dims.dim4).opacity(self.dims.dim3),
            indicator: self.colors.feedback.info.opacity(self.dims.dim3),
            handle: self.colors.feedback.info.opacity(self.dims.dim3),
            handleActiveIndicator: self.colors.feedback.infoContainer.opacity(self.dims.dim3)
        )

        // WHEN
        let colors = useCase.execute(theme: self.theme,
                                     intent: .info,
                                     isEnabled: false)

        // THEN
        XCTAssertEqual(colors, expectedColors)
    }
}
