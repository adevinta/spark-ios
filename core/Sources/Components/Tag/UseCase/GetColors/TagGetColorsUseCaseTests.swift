//
//  TagGetColorsUseCaseTests.swift
//  SparkCoreTests
//
//  Created by robin.lemaire on 06/04/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore
import SparkThemingTesting

final class TagGetColorsUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_variant_filled() throws {
        // GIVEN
        let getContentColorsUseCase = TagGetContentColorsUseCaseableGeneratedMock()
        let getContentColorsUseCaseReturnValue = TagContentColors.mocked()
        getContentColorsUseCase.executeWithIntentAndColorsReturnValue = getContentColorsUseCaseReturnValue
        let colors = ColorsGeneratedMock()
        let theme = ThemeGeneratedMock()
        theme.underlyingColors = colors

        let useCase = TagGetColorsUseCase(getContentColorsUseCase: getContentColorsUseCase)
        let variant = TagVariant.filled
        let intent = TagIntent.alert

        // WHEN
        let sut = useCase.execute(
            theme: theme,
            intent: intent,
            variant: variant
        )

        // THEN
        XCTAssertEqual(
            getContentColorsUseCase.executeWithIntentAndColorsCallsCount,
            1,
            "getContentColorsUseCase.execute should be called once"
        )
        let receivedArguments = try XCTUnwrap(
            getContentColorsUseCase.executeWithIntentAndColorsReceivedArguments,
            "Couldn't unwrap getContentColorsUseCase.execute received arguments"
        )
        XCTAssertIdentical(
            receivedArguments.colors as? ColorsGeneratedMock,
            colors,
            "Wrong getContentColorsUseCase.executereceived colors"
        )
        XCTAssertEqual(
            receivedArguments.intent,
            .alert,
            "Wrong getContentColorsUseCase.executereceived intent"
        )

        let color = try XCTUnwrap(
            getContentColorsUseCaseReturnValue.color as? ColorTokenGeneratedMock,
            "Couldn't unwrap getContentColorsUseCaseReturnValue.color as a ColorTokenGeneratedMock"
        )
        XCTAssertIdentical(
            sut.backgroundColor as? ColorTokenGeneratedMock,
            color,
            "Wrong sut.backgroundColor"
        )
        XCTAssertIdentical(
            sut.borderColor as? ColorTokenGeneratedMock,
            color,
            "Wrong sut.borderColor"
        )

        let onColor = try XCTUnwrap(
            getContentColorsUseCaseReturnValue.onColor as? ColorTokenGeneratedMock,
            "Couldn't unwrap getContentColorsUseCaseReturnValue.onColor as a ColorTokenGeneratedMock"
        )
        XCTAssertIdentical(
            sut.foregroundColor as? ColorTokenGeneratedMock,
            onColor,
            "Wrong sut.foregroundColor"
        )
    }

    func test_execute_variant_outlined() throws {
        // GIVEN
        let getContentColorsUseCase = TagGetContentColorsUseCaseableGeneratedMock()
        let getContentColorsUseCaseReturnValue = TagContentColors.mocked()
        getContentColorsUseCase.executeWithIntentAndColorsReturnValue = getContentColorsUseCaseReturnValue
        let colors = ColorsGeneratedMock()
        let theme = ThemeGeneratedMock()
        theme.underlyingColors = colors

        let useCase = TagGetColorsUseCase(getContentColorsUseCase: getContentColorsUseCase)
        let variant = TagVariant.outlined
        let intent = TagIntent.danger

        // WHEN
        let sut = useCase.execute(
            theme: theme,
            intent: intent,
            variant: variant
        )

        // THEN
        XCTAssertEqual(
            getContentColorsUseCase.executeWithIntentAndColorsCallsCount,
            1,
            "getContentColorsUseCase.execute should be called once"
        )
        let receivedArguments = try XCTUnwrap(
            getContentColorsUseCase.executeWithIntentAndColorsReceivedArguments,
            "Couldn't unwrap getContentColorsUseCase.execute received arguments"
        )
        XCTAssertIdentical(
            receivedArguments.colors as? ColorsGeneratedMock,
            colors,
            "Wrong getContentColorsUseCase.executereceived colors"
        )
        XCTAssertEqual(
            receivedArguments.intent,
            .danger,
            "Wrong getContentColorsUseCase.executereceived intent"
        )

        let color = try XCTUnwrap(
            getContentColorsUseCaseReturnValue.color as? ColorTokenGeneratedMock,
            "Couldn't unwrap getContentColorsUseCaseReturnValue.color as a ColorTokenGeneratedMock"
        )
        XCTAssertIdentical(
            sut.foregroundColor as? ColorTokenGeneratedMock,
            color,
            "Wrong sut.foregroundColor")
        XCTAssertIdentical(
            sut.borderColor as? ColorTokenGeneratedMock,
            color,
            "Wrong sut.borderColor"
        )

        XCTAssertTrue(
            sut.backgroundColor.isClear,
            "Wrong sut.backgroundColor"
        )
    }

    func test_execute_variant_tinted() throws {
        // GIVEN
        let getContentColorsUseCase = TagGetContentColorsUseCaseableGeneratedMock()
        let getContentColorsUseCaseReturnValue = TagContentColors.mocked()
        getContentColorsUseCase.executeWithIntentAndColorsReturnValue = getContentColorsUseCaseReturnValue
        let colors = ColorsGeneratedMock()
        let theme = ThemeGeneratedMock()
        theme.underlyingColors = colors

        let useCase = TagGetColorsUseCase(getContentColorsUseCase: getContentColorsUseCase)
        let variant = TagVariant.tinted
        let intent = TagIntent.success

        // WHEN
        let sut = useCase.execute(
            theme: theme,
            intent: intent,
            variant: variant
        )

        // THEN
        XCTAssertEqual(
            getContentColorsUseCase.executeWithIntentAndColorsCallsCount,
            1,
            "getContentColorsUseCase.execute should be called once"
        )
        let receivedArguments = try XCTUnwrap(
            getContentColorsUseCase.executeWithIntentAndColorsReceivedArguments,
            "Couldn't unwrap getContentColorsUseCase.execute received arguments"
        )
        XCTAssertIdentical(
            receivedArguments.colors as? ColorsGeneratedMock,
            colors,
            "Wrong getContentColorsUseCase.executereceived colors"
        )
        XCTAssertEqual(
            receivedArguments.intent,
            .success,
            "Wrong getContentColorsUseCase.executereceived intent"
        )

        let containerColor = try XCTUnwrap(
            getContentColorsUseCaseReturnValue.containerColor as? ColorTokenGeneratedMock,
            "Couldn't unwrap getContentColorsUseCaseReturnValue.containerColor as a ColorTokenGeneratedMock"
        )
        XCTAssertIdentical(
            sut.backgroundColor as? ColorTokenGeneratedMock,
            containerColor,
            "Wrong sut.foregroundColor")
        XCTAssertIdentical(
            sut.borderColor as? ColorTokenGeneratedMock,
            containerColor,
            "Wrong sut.borderColor"
        )

        let onContainerColor = try XCTUnwrap(
            getContentColorsUseCaseReturnValue.onContainerColor as? ColorTokenGeneratedMock,
            "Couldn't unwrap getContentColorsUseCaseReturnValue.onContainerColor as a ColorTokenGeneratedMock"
        )
        XCTAssertIdentical(
            sut.foregroundColor as? ColorTokenGeneratedMock,
            onContainerColor,
            "Wrong sut.foregroundColor"
        )
    }
}
