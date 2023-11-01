//
//  RadioButtonViewModelTests.swift
//  SparkCoreTests
//
//  Created by michael.zimmermann on 13.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
@testable import SparkCore
import SwiftUI
import XCTest

final class RadioButtonViewModelTests: XCTestCase {

    // MARK: - Properties
    var theme: ThemeGeneratedMock!
    var bindingValue: Int = 0
    var subscriptions: Set<AnyCancellable>!

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.subscriptions = Set<AnyCancellable>()
        // Given
        self.theme = ThemeGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_opacity_for_enabled() throws {
        // Given
        let sut = self.sut(intent: .basic)

        // When
        sut.set(enabled: true)
        let opacity = sut.opacity

        // Then
        XCTAssertEqual(opacity, 1.00)
    }

    func test_opacity_for_disabled() throws {
        // Given
        let sut = self.sut(intent: .basic)

        // When
        sut.set(enabled: false)
        let opacity = sut.opacity

        // Then
        XCTAssertEqual(opacity, 0.40)
    }

    func test_spacings() {
        // When
        let spacings = sutValues(for: \.spacing)

        // Then
        XCTAssertEqual(spacings, Array(repeating: 5.0, count: 9))
    }

    func test_fonts() {
        // When
        let fonts = sutValues(for: \.font.font)

        // Then
        XCTAssertEqual(fonts, Array(repeating: Font.body, count: 9))
    }

    func test_colors_reset_when_selected_value_set() {
        // Given
        let sut = self.sut(intent: .basic)
        let expectation = XCTestExpectation(description: "Colors published when selection changes.")
        expectation.expectedFulfillmentCount = 2

        sut.$colors.sink(receiveValue: { _ in
            expectation.fulfill()
        }).store(in: &self.subscriptions)

        // When
        sut.set(selected: true)

        // Then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(self.bindingValue, 1)
    }

    func test_theme_update_publishes_changed_values() {
        // Given
        let sut = self.sut(intent: .basic)
        let expectation = XCTestExpectation(description: "Changes to theme publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip4(sut.$opacity, sut.$spacing, sut.$font, sut.$colors)

        Publishers.Zip(publishers, sut.$colors).sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.set(theme: ThemeGeneratedMock.mocked())

        // Then
        wait(for: [expectation], timeout: 0.5)
    }

    func test_state_update_publishes_changed_values() {
        // Given
        let sut = self.sut(intent: .basic)
        let expectation = XCTestExpectation(description: "Changes to state publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        Publishers.Zip(sut.$isDisabled, sut.$colors).sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.set(enabled: false)

        // Then
        wait(for: [expectation], timeout: 0.5)
    }

    func test_spacing_update_publishes_changed_values() {
        // Given
        let sut = self.sut(intent: .basic)
        let expectation = XCTestExpectation(description: "Changes to label position publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        var spacings = [CGFloat]()

        sut.$spacing.sink { spacing in
            spacings.append(spacing)
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.set(alignment: .leading)

        // Then
        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(spacings, [self.theme.layout.spacing.medium, self.theme.layout.spacing.xxxLarge])
    }

    // MARK: - Private Helper Functions

    private func sutValues<T>(for keyPath: KeyPath<RadioButtonViewModel<Int>, T>) -> [T] {
        return RadioButtonIntent.allCases
            .map(self.sut(intent:))
            .map{ $0[keyPath: keyPath] }
    }

    private func sut(intent: RadioButtonIntent) -> RadioButtonViewModel<Int> {
        let seletedId = Binding(
            get: { self.bindingValue },
            set: { self.bindingValue = $0 }
        )

        return RadioButtonViewModel(
            theme: self.theme,
            intent: intent,
            id: 1,
            label: .right("Test"),
            selectedID: seletedId)
    }
}

private extension Theme where Self == ThemeGeneratedMock {
    static func mocked() -> Self {
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock.mocked()
        let layout = LayoutGeneratedMock.mocked()
        let dims = DimsGeneratedMock.mocked()
        let typography = TypographyGeneratedMock.mocked()

        theme.colors = colors
        theme.layout = layout
        theme.typography = typography
        theme.dims = dims

        return theme
    }
}
