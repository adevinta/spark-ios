//
//  RadioButtonGroupViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 05.07.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import XCTest

final class RadioButtonGroupViewModelTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()

    // MARK: - Tests
    public func test_expect_all_values_published_on_setup() {
        // Given
        let sut = sut(intent: .basic)
        let expectation = expectation(description: "Wait for subscriptions to be published")
        expectation.expectedFulfillmentCount = 1

        let publisher = Publishers.Zip(
            Publishers.Zip4(sut.$sublabelFont, sut.$titleFont, sut.$titleColor, sut.$sublabelColor),
            Publishers.Zip(sut.$spacing, sut.$labelSpacing)
        )

        publisher.sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        wait(for: [expectation], timeout: 0.1)
    }

    public func test_theme_change() {
        // Given
        let sut = sut(intent: .basic)
        let expectation = expectation(description: "Wait for subscriptions to be published")
        expectation.expectedFulfillmentCount = 2

        let publisher = Publishers.Zip(
            Publishers.Zip4(sut.$sublabelFont, sut.$titleFont, sut.$titleColor, sut.$sublabelColor),
            Publishers.Zip(sut.$spacing, sut.$labelSpacing)
        )

        publisher.sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        sut.theme = ThemeGeneratedMock.mocked()

        wait(for: [expectation], timeout: 0.1)
    }

    public func test_intent_change() {
        // Given
        let sut = sut(intent: .basic)
        let expectation = expectation(description: "Wait for sublabel color to be published")
        expectation.expectedFulfillmentCount = 2


        sut.$sublabelColor.sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        sut.intent = .alert

        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: - Private helpers
    private func sut(intent: RadioButtonIntent) -> RadioButtonGroupViewModel<Void> {
        let useCase = GetRadioButtonGroupColorUseCaseableGeneratedMock()
        useCase.executeWithColorsAndIntentReturnValue = ColorTokenGeneratedMock.random()
        let theme = ThemeGeneratedMock.mocked()

        let sut = RadioButtonGroupViewModel(
            theme: theme,
            intent: intent,
            content: (),
            useCase: useCase
        )

        return sut
    }
}
