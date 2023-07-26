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

    var theme: ThemeGeneratedMock!
    var useCase: IconGetColorUseCaseableGeneratedMock!
    var colorToken: ColorTokenGeneratedMock!
    var cancellables: Set<AnyCancellable>!
    var sut: IconViewModel!

    // MARK: - Setup

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
        self.useCase = IconGetColorUseCaseableGeneratedMock()
        self.colorToken = ColorTokenGeneratedMock.random()
        self.cancellables = .init()

        self.useCase.executeWithIntentAndColorsReturnValue = colorToken

        self.sut = IconViewModel(
            theme: self.theme,
            intent: .alert,
            size: .small,
            iconGetUseCase: self.useCase
        )
    }

    // MARK: - Tests

    func test_init() throws {
        for iconIntent in IconIntent.allCases {
            for iconSize in IconSize.allCases {
                // GIVEN
                self.sut = IconViewModel(
                    theme: self.theme,
                    intent: iconIntent,
                    size: iconSize,
                    iconGetUseCase: self.useCase
                )

                let expectedIconColor = self.useCase.execute(
                    for: iconIntent,
                    colors: self.theme.colors
                )

                // THEN
                XCTAssertIdentical(
                    self.sut.theme as? ThemeGeneratedMock,
                    self.theme,
                    "Icon theme doesn't match expected theme"
                )

                XCTAssertIdentical(
                    self.sut.color as? ColorTokenGeneratedMock,
                    expectedIconColor as? ColorTokenGeneratedMock,
                    "Icon color doesn't match the expected color"
                )

                XCTAssertTrue(
                    self.sut.size.value == iconSize.value,
                    "Icon size doesn't match the given size"
                )
            }
        }
    }

    func test_set_intent() throws {
        for iconIntent in IconIntent.allCases {
            // GIVEN
            self.sut = IconViewModel(
                theme: self.theme,
                intent: iconIntent,
                size: .medium,
                iconGetUseCase: self.useCase
            )

            // THEN
            XCTAssertEqual(self.sut.intent, iconIntent, "Icon intent doesn't match the given intent")

            self.sut.set(intent: randomizeIntentAndRemoveCurrent(iconIntent))

            XCTAssertNotEqual(self.sut.intent, iconIntent, "Icon intent should not match the initial given intent")
        }
    }

    func test_set_size() {
        for iconSize in IconSize.allCases {
            // GIVEN
            self.sut = IconViewModel(
                theme: self.theme,
                intent: .neutral,
                size: iconSize,
                iconGetUseCase: self.useCase
            )

            // THEN
            XCTAssertEqual(self.sut.size, iconSize, "Icon size doesn't match the given size")

            self.sut.set(size: randomizeSizeAndRemoveCurrent(iconSize))

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
            iconGetUseCase: self.useCase
        )

        self.sut.$color.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.set(intent: .secondary)

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
            iconGetUseCase: self.useCase
        )

        self.sut.$size.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // WHEN
        self.sut.set(size: .extraLarge)

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
