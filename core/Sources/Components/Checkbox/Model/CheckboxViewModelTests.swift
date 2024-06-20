//
//  CheckboxViewModelTests.swift
//  SparkCore
//
//  Created by janniklas.freundt.ext on 17.04.23.
//  Copyright © 2023 Adevinta. All rights reserved.
//

import Combine
import SwiftUI
import XCTest
@testable import SparkCore

// swiftlint:disable force_unwrapping
final class CheckboxViewModelTests: XCTestCase {

    var theme: ThemeGeneratedMock!
    var cancellable = Set<AnyCancellable>()
    var checkedImage = IconographyTests.shared.checkmark

    // MARK: - Setup
    override func setUpWithError() throws {
        try super.setUpWithError()

        self.theme = ThemeGeneratedMock.mocked()
    }

    // MARK: - Tests
    func test_init() throws {
        let states = [true, false]

        for state in states {
            // Given
            let viewModel = sut(isEnabled: state)

            // Then
            XCTAssertEqual(state, viewModel.isEnabled, "wrong state")
            XCTAssertNotNil(viewModel.theme, "no theme set")
            XCTAssertNotNil(viewModel.colors, "no colors set")
            XCTAssertNotNil(viewModel.intent, "no intents set")
            XCTAssertNotNil(viewModel.alignment, "no alignment set")

            XCTAssertIdentical(viewModel.theme as? ThemeGeneratedMock,
                               self.theme,
                               "Wrong typography value")

            XCTAssertEqual(viewModel.text.leftValue?.string, "Text", "text does not match")
            XCTAssertEqual(viewModel.checkedImage.leftValue, self.checkedImage, "Checked image does not match")
            XCTAssertEqual(viewModel.alignment, .left, "Alignment does not match")
            XCTAssertEqual(viewModel.intent, .main, "Intent does not match")
            XCTAssertEqual(viewModel.selectionState, .unselected, "Selection state does not match")
        }
    }

    func test_opacity() throws {
        // Given
        let opacities = self.sutValues(for: \.opacity)

        // Then
        XCTAssertEqual(opacities, [self.theme.dims.none, self.theme.dims.dim3])
    }

    func test_isEnabled() {
        // Given
        let disabledStates = self.sutValues(for: \.isEnabled)

        // Then
        XCTAssertEqual(disabledStates, [true, false])
    }

    func test_text() {
        // Given
        let sut = self.sut(isEnabled: true, attributeText: NSAttributedString("Text"))

        // When
        sut.text = .right("Text")

        // Then
        XCTAssertNotNil(sut.text.rightValue)
    }

    func test_attributeText() {
        // Given
        let sut = self.sut(isEnabled: true)

        // When
        sut.text = .left(NSAttributedString("Text"))

        // Then
        XCTAssertNotNil(sut.text.leftValue)
    }

    func test_updateColorsMethod_afterIntentIsSet() async {
        // Given
        let sut = self.sut(isEnabled: true, attributeText: NSAttributedString("Text"))
        var isColorsUpdated = false
        // When
        sut.intent = .basic

        let expectation = expectation(description: "Colors are updates")

        sut.$colors.sink(receiveValue: { _ in
            isColorsUpdated = true
            expectation.fulfill()
        })
        .store(in: &cancellable)

        await fulfillment(of: [expectation], timeout: 2.0)

        // Then
        XCTAssertTrue(isColorsUpdated)
    }

    // MARK: - Private Helper Functions
    private func sutValues<T>(for keyPath: KeyPath<CheckboxViewModel, T>) -> [T] {
        // Given
        let statesToTest: [Bool] = [true, false]

        return statesToTest
            .map{ self.sut(isEnabled: $0)}
            .map{ $0[keyPath: keyPath] }
    }

    private func sut(isEnabled: Bool, attributeText: NSAttributedString? = nil) -> CheckboxViewModel {
        return CheckboxViewModel(
            text: attributeText == nil ? .left(NSAttributedString("Text")) : .left(attributeText!),
            checkedImage: .left(self.checkedImage),
            theme: self.theme,
            isEnabled: isEnabled,
            selectionState: .unselected
        )
    }
}

private extension Theme where Self == ThemeGeneratedMock {
    static var mock: Self {
        let theme = ThemeGeneratedMock()
        let colors = ColorsGeneratedMock()

        colors.base = ColorsBaseGeneratedMock.mocked()
        colors.main = ColorsMainGeneratedMock.mocked()
        colors.feedback = ColorsFeedbackGeneratedMock.mocked()
        theme.colors = colors
        theme.dims = DimsGeneratedMock.mocked()

        return theme
    }
}
