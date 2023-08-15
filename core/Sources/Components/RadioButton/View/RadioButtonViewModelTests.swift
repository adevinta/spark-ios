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
    func test_opacity() throws {
        // When
        let opacities = sutValues(for: \.opacity)

        // Then
        XCTAssertEqual(opacities, [1.0, 0.40, 1.0, 1.0, 1.0, 1.0, 1.0])
    }

    func test_is_disabled() {
        // When
        let disabledStates = sutValues(for: \.isDisabled)

        // Then
        XCTAssertEqual(disabledStates, [false, true, false, false, false, false, false])
    }

    func test_spacings() {
        // When
        let spacings = sutValues(for: \.spacing)

        // Then
        XCTAssertEqual(spacings, Array(repeating: 5.0, count: 7))
    }

    func test_fonts() {
        // When
        let fonts = sutValues(for: \.font.font)

        // Then
        XCTAssertEqual(fonts, Array(repeating: Font.body, count: 7))
    }

    func test_surfaceColors() {
        // Given
        let onSurfaceColors = self.theme.colors.base.onSurface as! ColorTokenGeneratedMock
        onSurfaceColors.color = .red

        // When
        let surfaceColors = sutValues(for: \.surfaceColor.color)

        // Then
        XCTAssertEqual(surfaceColors, Array(repeating: Color.red, count: 7))
    }

    func test_colors_reset_when_selected_value_set() {
        // Given
        let sut = self.sut(state: .enabled)
        let expectation = XCTestExpectation(description: "Colors published when selection changes.")
        expectation.expectedFulfillmentCount = 2

        sut.$colors.sink(receiveValue: { _ in
            expectation.fulfill()
        }).store(in: &self.subscriptions)

        // When
        sut.setSelected()

        // Then
        wait(for: [expectation], timeout: 0.5)
        XCTAssertEqual(self.bindingValue, 1)
    }

    func test_theme_update_publishes_changed_values() {
        // Given
        let sut = self.sut(state: .enabled)
        let expectation = XCTestExpectation(description: "Changes to theme publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        let publishers = Publishers.Zip4(sut.$opacity, sut.$spacing, sut.$font, sut.$surfaceColor)

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
        let sut = self.sut(state: .enabled)
        let expectation = XCTestExpectation(description: "Changes to state publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        Publishers.Zip(sut.$isDisabled, sut.$colors).sink { _ in
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.set(groupState: .disabled)

        // Then
        wait(for: [expectation], timeout: 0.5)
    }

    func test_spacing_update_publishes_changed_values() {
        // Given
        let sut = self.sut(state: .enabled)
        let expectation = XCTestExpectation(description: "Changes to label position publishes value changes.")
        expectation.expectedFulfillmentCount = 2

        var spacings = [CGFloat]()

        sut.$spacing.sink { spacing in
            spacings.append(spacing)
            expectation.fulfill()
        }.store(in: &self.subscriptions)

        // When
        sut.set(labelPosition: .left)

        // Then
        wait(for: [expectation], timeout: 0.5)

        XCTAssertEqual(spacings, [self.theme.layout.spacing.medium, self.theme.layout.spacing.xxxLarge])
    }

    // MARK: - Private Helper Functions

    private func sutValues<T>(for keyPath: KeyPath<RadioButtonViewModel<Int>, T>) -> [T] {
        return RadioButtonGroupState.allCases
            .map(self.sut(state:))
            .map{ $0[keyPath: keyPath] }
    }

    private func sut(state: RadioButtonGroupState) -> RadioButtonViewModel<Int> {
        let seletedId = Binding(
            get: { self.bindingValue },
            set: { self.bindingValue = $0 }
        )

        return RadioButtonViewModel(theme: self.theme,
                                    id: 1,
                                    label: .right("Test"),
                                    selectedID: seletedId,
                                    groupState: state)

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
