//
//  IconViewModelTests.swift
//  SparkCore
//
//  Created by Jacklyn Situmorang on 25.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class IconViewModelTests: TestCase {

    // MARK: - Properties

    var theme: ThemeGeneratedMock = ThemeGeneratedMock.mocked()
    var cancellables = Set<AnyCancellable>()

    // MARK: - Tests

    func test_init() throws {
        // GIVEN

        for iconIntent in IconIntent.allCases {
            for iconSize in IconSize.allCases {
                // GIVEN
                let sut = IconViewModel(
                    theme: self.theme,
                    intent: iconIntent,
                    size: iconSize
                )

                let expectedIconColor = IconGetColorUseCase().execute(
                    for: iconIntent,
                    colors: self.theme.colors
                )

                // THEN
                XCTAssertIdentical(
                    sut.theme as? ThemeGeneratedMock,
                    self.theme,
                    "Icon theme doesn't match expected theme"
                )

                XCTAssertIdentical(
                    sut.color as? ColorTokenGeneratedMock,
                    expectedIconColor as? ColorTokenGeneratedMock,
                    "Icon color doesn't match the expected color"
                )

                XCTAssertTrue(
                    sut.size.value == iconSize.value,
                    "Icon size doesn't match the given size"
                )
            }
        }
    }

    func test_set_intent() throws {
        for iconIntent in IconIntent.allCases {
            // GIVEN
            let sut = IconViewModel(theme: self.theme, intent: iconIntent, size: .medium)

            // THEN
            XCTAssertEqual(sut.intent, iconIntent, "Icon intent doesn't match the given intent")

            sut.set(intent: randomizeIntentAndRemoveCurrent(iconIntent))

            XCTAssertNotEqual(sut.intent, iconIntent, "Icon intent should not match the initial given intent")
        }
    }

    func test_set_size() {
        for iconSize in IconSize.allCases {
            // GIVEN
            let sut = IconViewModel(theme: self.theme, intent: .neutral, size: iconSize)

            // THEN
            XCTAssertEqual(sut.size, iconSize, "Icon size doesn't match the given size")

            sut.set(size: randomizeSizeAndRemoveCurrent(iconSize))

            XCTAssertNotEqual(sut.size, iconSize, "Icon size should not match the initial given size")

        }
    }

    func test_color_subscription_on_intent_change() throws {
        // GIVEN
        let expectation = expectation(description: "Color updated on intent change")
        expectation.expectedFulfillmentCount = 2
        let sut = IconViewModel(theme: self.theme, intent: .alert, size: .medium)

        sut.$color.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        sut.set(intent: .secondary)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    func test_size_subscription_on_size_change() throws {
        // GIVEN
        let expectation = expectation(description: "Size changed")
        expectation.expectedFulfillmentCount = 2
        let sut = IconViewModel(theme: self.theme, intent: .alert, size: .medium)

        sut.$size.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        sut.set(size: .extraLarge)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    private func randomizeIntentAndRemoveCurrent(_ currentIntent: IconIntent) -> IconIntent {
        let filteredIntents = IconIntent.allCases.filter({ $0 != currentIntent })
        let randomIndex = Int.random(in: 0...filteredIntents.count - 1)

        return filteredIntents[randomIndex]
    }

    private func randomizeSizeAndRemoveCurrent(_ currentSize: IconSize) -> IconSize {
        let filteredSizes = IconSize.allCases.filter({ $0 != currentSize })
        let randomIndex = Int.random(in: 0...filteredSizes.count - 1)

        return filteredSizes[randomIndex]
    }
}
