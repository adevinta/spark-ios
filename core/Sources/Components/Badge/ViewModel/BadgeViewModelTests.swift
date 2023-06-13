//
//  BadgeViewModelTests.swift
//  SparkCore
//
//  Created by alex.vecherov on 17.05.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class BadgeViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock = ThemeGeneratedMock.mocked()

    // MARK: - Tests
    func test_init() throws {
        for badgeIntent in BadgeIntentType.allCases {
            // Given

            let viewModel = BadgeViewModel(theme: theme, intent: badgeIntent)

            let badgeExpectedColors = BadgeGetIntentColorsUseCase().execute(intentType: badgeIntent, on: theme.colors)

            // Then

            XCTAssertIdentical(viewModel.textColor as? ColorTokenGeneratedMock, badgeExpectedColors.foregroundColor as? ColorTokenGeneratedMock, "Text color doesn't match expected foreground")

            XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock, theme, "Badge theme doesn't match expected theme")

            XCTAssertTrue(viewModel.border.isEqual(to: theme, isOutlined: true), "Border border doesn't match expected")
        }
    }

    func test_set_value() throws {
        for badgeIntent in BadgeIntentType.allCases {
            // Given

            let expectedInitText = "20"
            let expectedUpdatedText = "233"
            let viewModel = BadgeViewModel(theme: theme, intent: badgeIntent, value: 20)

            // Then

            XCTAssertEqual(expectedInitText, viewModel.text, "Text doesn't match init value with standart format")

            viewModel.value = 233

            XCTAssertEqual(expectedUpdatedText, viewModel.text, "Text doesn't match incremented value with standart format")

            XCTAssertEqual(viewModel.textFont.font, theme.typography.captionHighlight.font, "Font is wrong")

            viewModel.size = .small

            XCTAssertEqual(viewModel.textFont.font, theme.typography.smallHighlight.font, "Font is wrong")
        }
    }

    func test_update_size() throws {
        for badgeIntent in BadgeIntentType.allCases {
            // Given

            let viewModel = BadgeViewModel(theme: theme, intent: badgeIntent, value: 20)

            // Then

            XCTAssertEqual(viewModel.size, .normal, "Badge should be .normal sized by default")

            XCTAssertEqual(viewModel.textFont.font, theme.typography.captionHighlight.font, "Font is wrong")

            viewModel.size = .small

            XCTAssertEqual(viewModel.textFont.font, theme.typography.smallHighlight.font, "Font is wrong")
        }
    }

    func test_update_intent() throws {
        for badgeIntent in BadgeIntentType.allCases {
            // Given

            let viewModel = BadgeViewModel(theme: theme, intent: badgeIntent, value: 20)

            // Then

            XCTAssertEqual(viewModel.intent, badgeIntent, "Intent type was set wrong")

            viewModel.intent = randomizeIntentAndExceptingCurrent(badgeIntent)

            XCTAssertNotEqual(viewModel.intent, badgeIntent, "Intent type was set wrong")
        }
    }

    private func randomizeIntentAndExceptingCurrent(_ currentIntentType: BadgeIntentType) -> BadgeIntentType {
        let filteredIntentTypes = BadgeIntentType.allCases.filter({ $0 != currentIntentType })
        let randomIndex = Int.random(in: 0...filteredIntentTypes.count - 1)

        return filteredIntentTypes[randomIndex]
    }
}

private extension BadgeBorder {
    func isEqual(to theme: Theme, isOutlined: Bool) -> Bool {
        return (isOutlined ? width == theme.border.width.medium : width == theme.border.width.none) &&
        radius == theme.border.radius.full &&
        color.color == theme.colors.base.surface.color
    }
}
