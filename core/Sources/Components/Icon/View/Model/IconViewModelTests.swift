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

final class IconViewModelTests: XCTestCase {

    // MARK: - Properties

    var theme: ThemeGeneratedMock!
    var getColorUseCase: IconGetColorUseCaseableGeneratedMock!
    var colorToken: ColorTokenGeneratedMock!
    var cancellables: Set<AnyCancellable>!
    var sut: IconViewModel!

    // MARK: - Setup

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
        self.getColorUseCase = IconGetColorUseCaseableGeneratedMock()
        self.colorToken = ColorTokenGeneratedMock.random()
        self.cancellables = .init()

        self.getColorUseCase.executeWithIntentAndColorsReturnValue = self.colorToken

        self.sut = IconViewModel(
            theme: self.theme,
            intent: .alert,
            size: .small,
            getColorUseCase: self.getColorUseCase
        )
    }

    // MARK: - Tests

    func test_init() throws {
        for iconIntent in IconIntent.allCases {
            for iconSize in IconSize.allCases {
                // GIVEN
                self.getColorUseCase.executeWithIntentAndColorsCallsCount = 0

                self.sut = IconViewModel(
                    theme: self.theme,
                    intent: iconIntent,
                    size: iconSize,
                    getColorUseCase: self.getColorUseCase
                )

                // THEN
                XCTAssertIdentical(
                    self.sut.theme as? ThemeGeneratedMock,
                    self.theme,
                    "Icon theme doesn't match expected theme"
                )

                XCTAssertIdentical(
                    self.sut.color as? ColorTokenGeneratedMock,
                    self.colorToken,
                    "Icon color doesn't match the expected color"
                )

                XCTAssertTrue(
                    self.sut.size.value == iconSize.value,
                    "Icon size doesn't match the given size"
                )

                self.testGetColorUseCaseExecute(
                    givenIntent: iconIntent,
                    expectedCallsCount: 1
                )
            }
        }
    }

    func test_set_theme() throws {
        // GIVEN
        self.getColorUseCase.executeWithIntentAndColorsCallsCount = 0
        let newTheme = ThemeGeneratedMock.mocked()

        // WHEN
        self.sut.set(theme: newTheme)
        self.theme = newTheme

        // THEN
        XCTAssertIdentical(
            self.sut.theme as? ThemeGeneratedMock,
            newTheme,
            "Theme is not updated"
        )

        self.testGetColorUseCaseExecute(givenIntent: .alert, expectedCallsCount: 1)
    }

    func test_set_intent() throws {
        for iconIntent in IconIntent.allCases {
            // GIVEN
            self.sut = IconViewModel(
                theme: self.theme,
                intent: iconIntent,
                size: .medium,
                getColorUseCase: self.getColorUseCase
            )

            self.getColorUseCase.executeWithIntentAndColorsCallsCount = 0

            // THEN

            XCTAssertEqual(self.sut.intent, iconIntent, "Icon intent doesn't match the given intent")
            self.testGetColorUseCaseExecute(
                expectedCallsCount: 0
            )

            let newIntent = self.randomizeIntentAndRemoveCurrent(iconIntent)
            self.sut.set(intent: newIntent)

            XCTAssertEqual(self.sut.intent, newIntent, "Icon intent should not match the initial given intent")
            self.testGetColorUseCaseExecute(
                givenIntent: newIntent,
                expectedCallsCount: 1
            )
        }
    }

    func test_set_size() {
        for iconSize in IconSize.allCases {
            // GIVEN
            self.sut = IconViewModel(
                theme: self.theme,
                intent: .neutral,
                size: iconSize,
                getColorUseCase: self.getColorUseCase
            )

            // THEN
            XCTAssertEqual(self.sut.size, iconSize, "Icon size doesn't match the given size")

            self.sut.set(size: self.randomizeSizeAndRemoveCurrent(iconSize))

            XCTAssertNotEqual(self.sut.size, iconSize, "Icon size should not match the initial given size")
        }
    }

    func test_color_subscription_on_intent_change() throws {
        // GIVEN
        let expectation = expectation(description: "Color updated on intent change")
        expectation.expectedFulfillmentCount = 2
        self.sut = IconViewModel(
            theme: self.theme,
            intent: .alert,
            size: .medium,
            getColorUseCase: self.getColorUseCase
        )

        self.sut.$color.sink(receiveValue: { _ in
            expectation.fulfill()
        })
        .store(in: &self.cancellables)

        // WHEN
        self.sut.set(intent: .support)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    func test_size_subscription_on_size_change() throws {
        // GIVEN
        let expectation = expectation(description: "Size changed")
        expectation.expectedFulfillmentCount = 2
        self.sut = IconViewModel(
            theme: self.theme,
            intent: .alert,
            size: .medium,
            getColorUseCase: self.getColorUseCase
        )

        self.sut.$size.sink(receiveValue: { _ in
            expectation.fulfill()
        })
        .store(in: &self.cancellables)

        // WHEN
        self.sut.set(size: .extraLarge)

        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

    private func testGetColorUseCaseExecute(
        givenIntent: IconIntent? = nil,
        expectedCallsCount: Int
    ) {
        XCTAssertEqual(
            self.getColorUseCase.executeWithIntentAndColorsCallsCount,
            expectedCallsCount,
            "Wrong call number on execute on getColorUseCase"
        )

        if expectedCallsCount > 0 {
            let args = self.getColorUseCase.executeWithIntentAndColorsReceivedArguments

            XCTAssertEqual(
                args?.intent,
                givenIntent,
                "Wrong intent parameter on execute on getColorUseCase"
            )

            XCTAssertIdentical(
                args?.colors as? ColorsGeneratedMock,
                self.theme.colors as? ColorsGeneratedMock,
                "Wrong colors parameter on execute on getColorUseCase"
            )
        }
    }

    private func randomizeIntentAndRemoveCurrent(_ currentIntent: IconIntent) -> IconIntent {
        let filteredIntents = IconIntent.allCases.filter { $0 != currentIntent }
        let randomIndex = Int.random(in: 0...filteredIntents.count - 1)

        return filteredIntents[randomIndex]
    }

    private func randomizeSizeAndRemoveCurrent(_ currentSize: IconSize) -> IconSize {
        let filteredSizes = IconSize.allCases.filter { $0 != currentSize }
        let randomIndex = Int.random(in: 0...filteredSizes.count - 1)

        return filteredSizes[randomIndex]
    }
}
