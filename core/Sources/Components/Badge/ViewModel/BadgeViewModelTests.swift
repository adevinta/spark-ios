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
    var subscriptions = Set<AnyCancellable>()

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

            XCTAssertEqual(viewModel.size, .medium, "Badge should be .normal sized by default")

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

    func test_theme_change_publishes_values() {
        // Given
        let sut = BadgeViewModel(theme: self.theme, intent: .danger)
        let updateExpectation = expectation(description: "Attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip4(sut.$offset,
                                         sut.$textColor,
                                         sut.$backgroundColor,
                                         sut.$border)

        publishers.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.theme = ThemeGeneratedMock.mocked()

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_size_change_publishes_values() {
        // Given
        let sut = BadgeViewModel(theme: self.theme, intent: .danger, size: .medium)
        let updateExpectation = expectation(description: "Attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip3(sut.$textFont,
                                         sut.$badgeHeight,
                                         sut.$offset)

        publishers.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.size = .small

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_intent_change_publishes_values() {
        // Given
        let sut = BadgeViewModel(theme: self.theme, intent: .danger, size: .medium)
        let updateExpectation = expectation(description: "Attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip(sut.$textColor,
                                         sut.$backgroundColor)

        publishers.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.intent = .alert

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_value_change_publishes_values() {
        // Given
        let sut = BadgeViewModel(theme: self.theme, intent: .danger, size: .medium, value: 9)
        let updateExpectation = expectation(description: "Attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        sut.$text.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.value = 99

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    func test_formater_change_publishes_values() {
        // Given
        let sut = BadgeViewModel(theme: self.theme, intent: .danger, value: 9999, format: .default)
        let updateExpectation = expectation(description: "Attributes updated")
        updateExpectation.expectedFulfillmentCount = 2

        sut.$text.sink { _ in
            updateExpectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.format = .overflowCounter(maxValue: 99)

        // Then
        wait(for: [updateExpectation], timeout: 0.1)
    }

    // MARK: - Private functions
    private func randomizeIntentAndExceptingCurrent(_ currentIntentType: BadgeIntentType) -> BadgeIntentType {
        let filteredIntentTypes = BadgeIntentType.allCases.filter({ $0 != currentIntentType })
        let randomIndex = Int.random(in: 0...filteredIntentTypes.count - 1)

        return filteredIntentTypes[randomIndex]
    }
}

// MARK: - Private extensions
private extension BadgeBorder {
    func isEqual(to theme: Theme, isOutlined: Bool) -> Bool {
        return (isOutlined ? width == theme.border.width.medium : width == theme.border.width.none) &&
        radius == theme.border.radius.full &&
        color.color == theme.colors.base.surface.color
    }
}
