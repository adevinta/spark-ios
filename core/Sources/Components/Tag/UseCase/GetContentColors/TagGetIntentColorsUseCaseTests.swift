//
//  TagGetContentColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class  TagGetContentColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_intent_alert() {
        // GIVEN
        let intent = TagIntent.alert
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.feedback.alert,
                onColor: colors.feedback.onAlert,
                containerColor: colors.feedback.alertContainer,
                onContainerColor: colors.feedback.onAlertContainer
            )
        )
    }

    func test_execute_intent_danger() {
        // GIVEN
        let intent = TagIntent.danger
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.feedback.error,
                onColor: colors.feedback.onError,
                containerColor: colors.feedback.errorContainer,
                onContainerColor: colors.feedback.onErrorContainer
            )
        )
    }

    func test_execute_intent_info() {
        // GIVEN
        let intent = TagIntent.info
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.feedback.info,
                onColor: colors.feedback.onInfo,
                containerColor: colors.feedback.infoContainer,
                onContainerColor: colors.feedback.onInfoContainer
            )
        )
    }

    func test_execute_intent_neutral() {
        // GIVEN
        let intent = TagIntent.neutral
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.feedback.neutral,
                onColor: colors.feedback.onNeutral,
                containerColor: colors.feedback.neutralContainer,
                onContainerColor: colors.feedback.onNeutralContainer
            )
        )
    }

    func test_execute_intent_main() {
        // GIVEN
        let intent = TagIntent.main
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.main.main,
                onColor: colors.main.onMain,
                containerColor: colors.main.mainContainer,
                onContainerColor: colors.main.onMainContainer
            )
        )
    }

    func test_execute_intent_support() {
        // GIVEN
        let intent = TagIntent.support
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.support.support,
                onColor: colors.support.onSupport,
                containerColor: colors.support.supportContainer,
                onContainerColor: colors.support.onSupportContainer
            )
        )
    }

    func test_execute_intent_success() {
        // GIVEN
        let intent = TagIntent.success
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.feedback.success,
                onColor: colors.feedback.onSuccess,
                containerColor: colors.feedback.successContainer,
                onContainerColor: colors.feedback.onSuccessContainer
            )
        )
    }

    func test_execute_intent_accent() {
        // GIVEN
        let intent = TagIntent.accent
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.accent.accent,
                onColor: colors.accent.onAccent,
                containerColor: colors.accent.accentContainer,
                onContainerColor: colors.accent.onAccentContainer
            )
        )
    }

    func test_execute_intent_basic() {
        // GIVEN
        let intent = TagIntent.basic
        let useCase = TagGetContentColorsUseCase()
        let colors = ColorsGeneratedMock.mocked()

        // WHEN
        let sut = useCase.execute(intent: intent,
                                  colors: colors)

        // THEN
        XCTAssertEqual(
            sut,
            .init(
                color: colors.basic.basic,
                onColor: colors.basic.onBasic,
                containerColor: colors.basic.basicContainer,
                onContainerColor: colors.basic.onBasicContainer
            )
        )
    }
}
