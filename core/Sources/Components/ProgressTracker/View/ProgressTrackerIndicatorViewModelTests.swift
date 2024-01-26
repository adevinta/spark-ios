//
//  ProgressTrackerIndicatorViewModelTests.swift
//  SparkCoreSnapshotTests
//
//  Created by Michael Zimmermann on 25.01.24.
//  Copyright © 2024 Adevinta. All rights reserved.
//

import Combine
import XCTest

@testable import SparkCore

final class ProgressTrackerIndicatorViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    var theme: ThemeGeneratedMock!
    var colorsUseCase: ProgressTrackerGetColorsUseCaseableGeneratedMock!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        self.theme = ThemeGeneratedMock.mocked()
        self.colorsUseCase = ProgressTrackerGetColorsUseCaseableGeneratedMock()

        self.colorsUseCase
            .executeWithThemeAndIntentAndVariantAndStateReturnValue = .init(
                background: self.theme.colors.basic.basicContainer,
                outline: self.theme.colors.basic.onBasic,
                content: self.theme.colors.basic.basic
            )
    }

    // MARK: - Tests
    func test_initialization() {
        // Given
        let sut = self.sut(intent: .alert, variant: .tinted, size: .small, state: .selected)

        // Then
        XCTAssertEqual(sut.state, .selected, "Expected state to be selected")
        XCTAssertEqual(sut.intent, .alert, "Expected intent to be alert")
        XCTAssertEqual(sut.variant, .tinted, "Expected variant to be tinted")
        XCTAssertEqual(sut.size, .small, "Expected size to be small")
        XCTAssertIdentical(sut.theme as? ThemeGeneratedMock, self.theme, "Expected theme to be identical")

        XCTAssertEqual(sut.spacing, self.theme.layout.spacing.medium, "Expected spacing to be medium")

        XCTAssertEqual(self.colorsUseCase.executeWithThemeAndIntentAndVariantAndStateCallsCount, 1)
    }

    func test_update_theme() {
        // Given
        let sut = self.sut()
        let expectation = expectation(description: "Expect colors and spacing to have been triggered")
        expectation.expectedFulfillmentCount = 2

        let publisher = Publishers.Zip(sut.$colors, sut.$spacing)

        publisher.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.theme = self.theme

        // Then
        wait(for: [expectation])
    }

    func test_intent_change() {
        // Given
        let sut = self.sut(intent: .basic)
        let expectation = expectation(description: "Expect colors to have been triggered twice")
        expectation.expectedFulfillmentCount = 2

        sut.$colors.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.intent = .danger

        // Then
        wait(for: [expectation])
    }

    func test_variant_change() {
        // Given
        let sut = self.sut(variant: .outlined)
        let expectation = expectation(description: "Expect colors to have been triggered twice")
        expectation.expectedFulfillmentCount = 2

        sut.$colors.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.variant = .tinted

        // Then
        wait(for: [expectation])
    }

    func test_state_change() {
        // Given
        let sut = self.sut(state: .normal)
        let expectation = expectation(description: "Expect colors to have been triggered twice")
        expectation.expectedFulfillmentCount = 2

        sut.$colors.sink { _ in
            expectation.fulfill()
        }.store(in: &self.cancellables)

        // When
        sut.state = .pressed

        // Then
        wait(for: [expectation])
    }

    private func sut(
        intent: ProgressTrackerIntent = .basic,
        variant: ProgressTrackerVariant = .outlined,
        size: ProgressTrackerSize = .large,
        state: ProgressTrackerState = .normal) -> ProgressTrackerIndicatorViewModel<ProgressTrackerUIIndicatorContent> {
            return .init(
                theme: self.theme,
                intent: intent,
                variant: variant,
                size: size,
                content: ProgressTrackerUIIndicatorContent(),
                state: state,
                colorsUseCase: self.colorsUseCase
            )
        }

}
