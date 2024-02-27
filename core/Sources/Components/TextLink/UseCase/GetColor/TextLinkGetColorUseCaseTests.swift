//
//  TextLinkGetColorUseCaseTests.swift
//  SparkCoreUnitTests
//
//  Created by robin.lemaire on 05/12/2023.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import XCTest
import SwiftUI
@testable import SparkCore

final class TextLinkGetColorUseCaseTests: XCTestCase {

    // MARK: - Tests

    func test_execute_for_all_intents_when_isHighlighted_is_false() {
        // GIVEN
        let useCase = TextLinkGetColorUseCase()
        let colorsMock = ColorsGeneratedMock.mocked()
        
        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let colorToken = useCase.execute(
                intent: givenIntent,
                isHighlighted: false,
                colors: colorsMock
            )

            let expectedColorToken = givenIntent.expectedColorTokenWithoutHighlighted(
                from: colorsMock
            )

            // THEN
            XCTAssertIdentical(
                colorToken as? ColorTokenGeneratedMock,
                expectedColorToken as? ColorTokenGeneratedMock,
                "Wrong color for .\(givenIntent) case"
            )
        }
    }

    func test_execute_for_all_intents_when_isHighlighted_is_true() {
        // GIVEN
        let useCase = TextLinkGetColorUseCase()
        let colorsMock = ColorsGeneratedMock.mocked()

        let givenIntents = TextLinkIntent.allCases

        // WHEN
        for givenIntent in givenIntents {
            let colorToken = useCase.execute(
                intent: givenIntent,
                isHighlighted: true,
                colors: colorsMock
            )

            let expectedColorToken = givenIntent.expectedColorTokenWithHighlighted(
                from: colorsMock
            )

            // THEN
            XCTAssertIdentical(
                colorToken as? ColorTokenGeneratedMock,
                expectedColorToken as? ColorTokenGeneratedMock,
                "Wrong color for .\(givenIntent) case"
            )
        }
    }
}

// MARK: - Extension

private extension TextLinkIntent {

    func expectedColorTokenWithHighlighted(from colorsMock: ColorsGeneratedMock) -> any ColorToken {
        switch self {
        case .accent:
            return colorsMock.states.accentPressed
        case .alert:
            return colorsMock.states.alertPressed
        case .basic:
            return colorsMock.states.basicPressed
        case .danger:
            return colorsMock.states.errorPressed
        case .info:
            return colorsMock.states.infoPressed
        case .main:
            return colorsMock.states.mainPressed
        case .neutral:
            return colorsMock.states.neutralPressed
        case .onSurface:
            return colorsMock.base.onSurface
        case .success:
            return colorsMock.states.successPressed
        case .support:
            return colorsMock.states.supportPressed
        }
    }

    func expectedColorTokenWithoutHighlighted(from colorsMock: ColorsGeneratedMock) -> any ColorToken {
        switch self {
        case .accent:
            return colorsMock.accent.accent
        case .alert:
            return colorsMock.feedback.alert
        case .basic:
            return colorsMock.basic.basic
        case .danger:
            return colorsMock.feedback.error
        case .info:
            return colorsMock.feedback.info
        case .main:
            return colorsMock.main.main
        case .neutral:
            return colorsMock.feedback.neutral
        case .onSurface:
            return colorsMock.base.onSurface
        case .success:
            return colorsMock.feedback.success
        case .support:
            return colorsMock.support.support
        }
    }
}
